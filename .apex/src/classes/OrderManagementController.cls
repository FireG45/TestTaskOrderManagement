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

	@AuraEnabled
	public static void checkout(Product__c[] cart, String accountId) {
		String orderName = String.valueOf(cart.hashCode() + Id.valueOf(accountId).hashCode());

		OrderService.create(new Order__c(
				Name = orderName,
				AccountId__c = accountId,
				TotalProductCount__c = 0,
				TotalPrice__c = 0)
		);
		Order__c newOrder = OrderService.getByName(orderName);
		Map<Product__c, Integer> quantityMap = new Map<Product__c, Integer>();
		for (Product__c product : cart) {
			if (quantityMap.containsKey(product)) {
				quantityMap.put(product, quantityMap.get(product) + 1);
			} else {
				quantityMap.put(product, 1);
			}
		}

		List<OrderItem__c> orderItems = new List<OrderItem__c>();

		for (Product__c key : quantityMap.keySet()) {
			orderItems.add(
					new OrderItem__c(
							OrderId__c = newOrder.Id,
							ProductId__c = key.Id,
							Quantity__c = quantityMap.get(key),
							Price__c = key.Price__c)
			);
		}

		insert orderItems;
	}

	@AuraEnabled
	public static boolean isUserManager(String id) {
		return UserInfoService.isManger(id);
	}

	@AuraEnabled
	public static void createProduct(Product__c product) {
		ProductService.create(product);
	}

	@AuraEnabled
	public static String getNewImageLink(String product) {
		HttpRequest request = new HttpRequest();
		request.setEndPoint('http://www.glyffix.com/api/Image?word=' + product);
		request.setMethod('GET');
		request.setHeader('Accept', 'application/json');
		Http httpProtocol = new Http();
		HttpResponse response = httpProtocol.send(request);

		System.debug(response.getBody());
		return response.getBody();
	}
}