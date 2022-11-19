export function intMO (price, savings){
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


