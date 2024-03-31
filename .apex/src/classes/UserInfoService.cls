public class UserInfoService {
	public static boolean isManger(Id id) {
		return [SELECT IsManager__c FROM User WHERE Id = :id].IsManager__c;
	}
}