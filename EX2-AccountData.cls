public class AccountData {
    public Id accountId;
    public String accountName;
    public String primaryContactEmail;
    public Decimal openAmount = 0;
    public Decimal closedWonAmount = 0;
    public Decimal closedLostAmount = 0;

    public AccountData(Id accountId, String accountName) {
        this.accountId = accountId;
        this.accountName = accountName;
    }

    public void addOpportunity(Opportunity opp) {
        if ('Open'.equals(opp.StageName)) {
            openAmount += opp.Amount;
        } else if ('Closed Won'.equals(opp.StageName)) {
            closedWonAmount += opp.Amount;
        } else if ('Closed Lost'.equals(opp.StageName)) {
            closedLostAmount += opp.Amount;
        }
    }

    public String getEmailBody() {
        String emailBody = '<h1>Opportunities Summary for ' + accountName + '</h1>';
        emailBody += '<table><tr><th>Stage</th><th>Amount</th></tr>';
        emailBody += '<tr><td>Open</td><td>$' + openAmount + '</td></tr>';
        emailBody += '<tr><td>Closed Won</td><td>$' + closedWonAmount + '</td></tr>';
        emailBody += '<tr><td>Closed Lost</td><td>$' + closedLostAmount + '</td></tr>';
        emailBody += '</table>';
        return emailBody;
    }
}