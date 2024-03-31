public class AccountInfoService {
	public static Account getAccountInfoById(Id id) {
		try {
			return [SELECT Name, AccountNumber FROM Account WHERE Id = :id];
		} catch (QueryException ex) {
			System.debug(LoggingLevel.ERROR, ex.getMessage() + ' ID: ' + id);
			throw new HandledException(ex.getMessage());
		}
	}
}