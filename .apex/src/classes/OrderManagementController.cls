public class OrderManagementController {
	@AuraEnabled
	public static Account getAccountInfo(String accountId) {
		return AccountInfoService.getAccountInfoById(Id.valueOf(accountId));
	}

	@AuraEnabled
	public static Product__c[] getAllWithSearchAndFilter(String query, String type, String family) {
		if (query.length() == 0 && type.length() == 0 && family.length() == 0) return ProductService.getAll();
		if (query.length() != 0 && type.length() != 0 && family.length() != 0)
			return ProductService.searchFiltered(query, type, family);
		if (type.length() == 0 && family.length() == 0) return ProductService.search(query);
		return ProductService.getFilteredBy(type, family);
	}

	@AuraEnabled
	public static String[] getTypes() {
		return ProductService.getTypes();
	}

	@AuraEnabled
	public static String[] getFamilies() {
		return ProductService.getFamilies();
	}
}