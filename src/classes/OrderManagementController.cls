public class OrderManagementController {
	@AuraEnabled
	public static Account getAccountInfo(String accountId) {
		return AccountInfoService.getAccountInfoById(Id.valueOf(accountId));
	}

	@AuraEnabled
	public static Product__c[] getAllProducts() {
		return ProductService.getAll();
	}
}