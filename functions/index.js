//import fetch from 'node-fetch';
function intMO(price, savings) {
    var bc = 0.0375 * price;
    var nc = price * 0.02;
    var tt = price * 0.035;
    return {
        "caseDto": {
            "estate": {
                "zip": "80331",
                "city": "München",
                "federalState": "DE-BY"
            },
            "mainApplicant": {
                "city": "",
                "federalState": "",
                "netSalary": 0
            },
            "capital": {
                "equityCash": savings
            },
            "venture": {
                "reason": "KaufBest",
                "priceBuilding": price,
                "percentageBroker": 3.57,
                "percentageNotary": 2,
                "percentageTax": 3.5,
                "shownFunding": {
                    "equityCash": savings,
                    "loans": [{
                        "amount": price - savings + bc + nc + tt,
                        "maturity": 15,
                        "fullRepayment": false,
                        "amortisation": 2
                    }]
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
const fetch = require('node-fetch');

admin.initializeApp();

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
exports.addConfigurationStr = functions.runWith({
        timeoutSeconds: 540,
        memory: '1GB'
    }).firestore.document('/houses/{documentId}')
    .onCreate(async (snap, context) => {
        // Grab the current value of what was written to Firestore.
        const userid = snap.data().owner;

        const type = snap.data().building;
        const size = snap.data().scale;
        const area = snap.data().location;
        const specials = snap.data().specials;
        const eco = snap.data().eco;

        // Access the parameter `{documentId}` with `context.params`
        functions.logger.log('Got', context.params.documentId, userid, type, size, area);

        var typeprice = 1000; //in €
        var sizeqm = 100; //in qm
        var areafactor = 1.0; //in %/100

        if (type == "castle") {
            typeprice = 8000;
        } else if (type == "home") {
            typeprice = 4000;
        } else if (type == "cabin") {
            typeprice = 2000;
        } else if (type == "carton") {
            typeprice = 500;
        }

        sizeqm = size * 250;

        if (area == "mountain") {
            areafactor = 1.2;
        } else if (area == "arctic") {
            areafactor = 0.9;
        } else if (area == "island") {
            areafactor = 1.7;
        } else if (area == "bridge") {
            areafactor = 0.8;
        } else if (area == "jungle") {
            areafactor = 0.7;
        } else if (area == "slum") {
            areafactor = 0.4;
        } else if (area == "city") {
            areafactor = 1.3;
        }

        price = sizeqm * typeprice * areafactor;

        if (eco != null) {
            if (eco < 2) {
                price *= (1 - (eco * 0.1));
            } else {
                price += 200000;
            }
        }

        if (specials.includes('alpaka')) {
            price += 2500;
        }
        if (specials.includes('pot')) {
            price += 5;
        }
        if (specials.includes('david')) {
            price += 300000000;
        }
        if (specials.includes('palm')) {
            price += 5000;
        }
        if (specials.includes('pool')) {
            price += 20000;
        }

        const qsnap = await admin.firestore().collection('users').doc(userid).get();

        let startIncome = qsnap.data().currentIncome;
        let endIncome = qsnap.data().expectedIncome;

        if (endIncome <= startIncome) {
            endIncome = startIncome + 1;
        }

        let savings = qsnap.data().currentSavings;
        let presavingPeriod = 0;

        while (savings < 0.11 * price) {

            presavingPeriod += 1;

            let income = startIncome;
            if (presavingPeriod < 20) {
                income += (endIncome - startIncome) / 20 * presavingPeriod;
            } else {
                income = endIncome;
            }

            savings += 0.10 * income;
        }

        var req = JSON.stringify(intMO(price, savings));
        let error;
        var response = await fetch('https://www.interhyp.de/customer-generation/interest/marketOverview', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: req
            })
            .then(response => response.json())
            .catch((e) => error = e)

        let bank = "None";
        let loan = 0;
        let monthlyPayment = 0;
        let loanYears = 0;

        if (error == null) {
            let [parsedLoan, _] = JSON.parse(JSON.stringify(response));
            bank = parsedLoan.bankDetails.bankName;
            loan = parsedLoan.loanAmount;
            monthlyPayment = parsedLoan.monthlyPayment;
            loanYears = parsedLoan.totalDuration.years;
            functions.logger.log("got loan: " + loan + "€, " + monthlyPayment + " €/mo");
        } else {
            functions.logger.log("error on requesting loan: " + error);
        }

        //calculate wait time
        //y=ln(c1*x + c2)
        c2 = Math.exp(startIncome / 10000)
        c1 = (Math.exp(endIncome / 10000) - c2) / 20

        let cost = loan;
        if (cost == 0) {
            cost = price;
        }
        let i = 0;
        let savedSum = 0;
        let yearSaving = new Array();
        let yearSavingAcc = new Array();
        while (savedSum < price) {
            yearSaving.push(12 * Math.log(c1 * i + c2) * 1000);
            savedSum = savedSum + yearSaving[i];
            yearSavingAcc.push(savedSum);
            i = i + 1;
        }

        let waitYears = 0;
        while (waitYears < yearSaving.length) {
            let lnSum = 0;
            for (let i = 0; i < loanYears; i++) {
                lnSum = lnSum + yearSaving[waitYears + i];
            }
            if (lnSum >= price - yearSavingAcc[waitYears]) {
                break;
            }
            waitYears = waitYears + 1;
        }

        waitYears += presavingPeriod;

        functions.logger.log("waityears and loanyears " + waitYears + " " + loanYears);

        // You must return a Promise when performing asynchronous tasks inside a Functions such as
        // writing to Firestore.
        // Setting an 'uppercase' field in Firestore document returns a Promise.
        return snap.ref.set({
            price,
            waitYears,
            loanYears,
            monthlyPayment,
            bank,
            loan
        }, {
            merge: true
        });
    });