function intMO (price, savings){
    var bc = 0.0375*price;
    var nc = price*0.02;
    var tt = price*0.035;
    return {
        "caseDto":
        {
            "estate":
            {
                "zip": "80331",
                "city": "München",
                "federalState": "DE-BY"
            },
            "mainApplicant":
            {
                "city": "",
                "federalState": "",
                "netSalary": 0
            },
            "capital":
            {
                "equityCash": savings
            },
            "venture":
            {
                "reason": "KaufBest",
                "priceBuilding": price,
                "percentageBroker": 3.57,
                "percentageNotary": 2,
                "percentageTax": 3.5,
                "shownFunding":
                {
                    "equityCash": savings,
                    "loans":
                    [
                        {
                            "amount": price - savings + bc + nc + tt,
                            "maturity": 15,
                            "fullRepayment": false,
                            "amortisation": 2
                        }
                    ]
                },
                "brokerCosts": bc,
                "notaryCosts": nc,
                "transferTax": tt
            },
            "calledBy": "zinscheck18"
        },
        "numberOfResults": 1
    }
}

// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
const { user } = require('firebase-functions/v1/auth');
admin.initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into 
// Firestore under the path /messages/:documentId/original
exports.addUser = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const name = req.query.name;
    const income = req.query.income;
    const savings = req.query.savings;
    const targetincome = req.query.targetincome;
    const character = req.query.character;
    //const income = req.query.income
    // Push the new message into Firestore using the Firebase Admin SDK.
    const writeResult = await admin.firestore().collection('users').add({
        name: name,
        income: income,
        savings: savings,
        targetincome: targetincome,
        character: character});
  // Send back a message that we've successfully written the message
  res.json({result: `User with ID: ${writeResult.id} added.`});
});

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
exports.addUserStr = functions.firestore.document('/users/{documentId}')
    .onCreate((snap, context) => {
        // Grab the current value of what was written to Firestore.
        const name = snap.data().name;
        const income = snap.data().income;
        const savings = snap.data().savings;
        const targetincome = snap.data().targetincome;
        const character = snap.data().character;

        // Access the parameter `{documentId}` with `context.params`
        functions.logger.log('Got', context.params.documentId, name, income, );
        
        const mergeStr = name + income + savings + targetincome + character;
        
        // You must return a Promise when performing asynchronous tasks inside a Functions such as
        // writing to Firestore.
        // Setting an 'uppercase' field in Firestore document returns a Promise.
        return snap.ref.set({mergeStr}, {merge: true});
    });

// Take the text parameter passed to this HTTP endpoint and insert it into 
// Firestore under the path /messages/:documentId/original
exports.addConfiguration = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const userid = req.query.userid;
    const type = req.query.type;
    const size = req.query.size;
    const area = req.query.area;
    //const addons = req.query.addons;
    // Push the new message into Firestore using the Firebase Admin SDK.
    const writeResult = await admin.firestore().collection('configurations').add({
        userid: userid,
        type: type,
        size: size,
        area: area});
    // Send back a message that we've successfully written the message
    res.json({result: `Configuration with ID: ${writeResult.id} added.`});
});

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
exports.addConfigurationStr = functions.firestore.document('/configurations/{documentId}')
    .onCreate(async(snap, context) => {
        // Grab the current value of what was written to Firestore.
        const userid = snap.data().userid;
        const type = snap.data().type;
        const size = snap.data().size;
        const area = snap.data().area;

        // Access the parameter `{documentId}` with `context.params`
        functions.logger.log('Got', context.params.documentId, userid, type, size, area);
        
        const mergeStr = userid + type + size + area;

        var typeprice = 1000;   //in €
        var sizeqm = 100;       //in qm
        var areafactor = 1.0;   //in %/100

        if (type == "villa") {
            typeprice = 5000;
        } else if (type == "family"){
            typeprice = 3000;
        } else if (type == "crip"){
            typeprice = 2000;
        }

        if (size == "big"){
            sizeqm = 500;
        } else if (size == "medium"){
            sizeqm = 250;
        } else if (size == "smol"){
            sizeqm = 100;
        }

        if (area == "mountain"){
            areafactor = 1.1;
        } else if (area == "antarctica"){
            areafactor = 0.7;
        } else if (area == "beach"){
            areafactor = 1.3;
        }

        price = sizeqm*typeprice*areafactor;

        const qsnap = await admin.firestore().collection('users').doc(userid).get();

        var req = JSON.stringify(intMO(price, qsnap.data().savings));
        let error = false;
        var response = await fetch('https://www.interhyp.de/customer-generation/interest/marketOverview', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: req
        })
        .then(response => response.json())
        .catch((e) => error = true)
        
        let configurationId = context.params.documentId;
        let bank = "None";
        let loan = 0;
        let monthlyPayment = 0;
        let loanYears = 0;

        if(error==false){
            let [ parsedLoan, _ ] = JSON.parse(JSON.stringify(response));
            let bank = parsedLoan.bankDetails.bankName;
            let loan = parsedLoan.loanAmount;
            let monthlyPayment = parsedLoan.monthlyPayment;
            let loanYears = parsedLoan.totalDuration.years;
        }
        
        const writeResult = await admin.firestore().collection('loans').add({
            ConfigurationId: configurationId,
            bank: bank,
            loan: loan,
            monthlyPayment: monthlyPayment,
            loanYears: loanYears});
        
        //calculate wait time
        //y=ln(c1*x + c2)
        c2 = Math.exp(qsnap.data().income/1000)
        c1 = (Math.exp(qsnap.data().targetincome/1000)-c2)/20
        
        let cost = loan;
        if (cost == 0){
            cost = price;
        }
        let i = 0;
        let savedSum = 0;
        let yearSaving = new Array();
        let yearSavingAcc = new Array();
        while(savedSum<price) {
            yearSaving.push(12*Math.log(c1*i + c2)*1000);
            savedSum = savedSum + yearSaving[i];
            yearSavingAcc.push(savedSum);
            i = i + 1;
        }

        let waitYears = 0;
        while(waitYears<yearSaving.length){
            let lnSum = 0;
            for(let i = 0; i < loanYears; i++){
                lnSum = lnSum + yearSaving[waitYears+i];
            }
            if(lnSum >= price - yearSavingAcc[waitYears]){
                break;
            }
            waitYears = waitYears + 1;
        }

        functions.logger.log("waityears and loanyears " + waitYears + " " + loanYears);

        // You must return a Promise when performing asynchronous tasks inside a Functions such as
        // writing to Firestore.
        // Setting an 'uppercase' field in Firestore document returns a Promise.
        return snap.ref.set({price, waitYears, loanYears}, {merge: true});
    });