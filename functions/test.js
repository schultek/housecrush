monthlyPayment = 4000;
years = 20;
loanAmount = 960000;
income = 1000;
targetincome = 2000;

//calculate wait time
//y=ln(c1*x + c2)
c2 = Math.exp(income/1000)
c1 = (Math.exp(targetincome/1000)-c2)/20

let i = 0;
let savedSum = 0.0;
let bufferYears = 0;
let yearSaving = new Array();
let yearSavingAcc = new Array();
while(bufferYears<years) {
    yearSaving.push(12.0*Math.log((c1*i) + c2)*1000.0);
    savedSum = savedSum + yearSaving[i];
    yearSavingAcc.push(savedSum);
    bufferYears = savedSum/(12*monthlyPayment);
    i = i + 1;
    console.log(bufferYears)
    console.log(c1 + " " + c2);
    console.log(yearSaving);
    console.log(yearSaving[0]);
    console.log(yearSaving[1]);
    console.log(12.0*Math.log((c1*i) + c2)*1000.0);
    console.log(i);
}

let waitYears = 0;
while(waitYears<yearSaving.length){
    let lnSum = 0;
    for(let i = 0; i < years; i++){
        lnSum = lnSum + yearSaving[waitYears+i];
    }
    if(lnSum >= loanAmount - yearSavingAcc[waitYears]){
        break;
    }
    waitYears = waitYears + 1;
}

console.log(waitYears + " " + years)