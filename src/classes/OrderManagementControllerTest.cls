@IsTest
private class OrderManagementControllerTest {

	@IsTest
	static void testGetAccountInfo() {
		insert new Account(Name = 'TEST', AccountNumber = '1234567890', Description = 'DESC');

		Account refAccount = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'TEST'];
		Account gotAccount = OrderManagementController.getAccountInfo(String.valueOf(refAccount.Id));

		System.assertEquals(refAccount.Name, gotAccount.Name);
		System.assertEquals(refAccount.AccountNumber, gotAccount.AccountNumber);
	}

	@IsTest
	static void testGetAllWithSearchAndFilter() {
		List<Product__c> productList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1', Type__c = 'Type1', Family__c = 'Family1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4', Type__c = 'Type1', Family__c = 'Family1')
		});

		insert productList;

		Product__c[] allProducts;
		Product__c[] gotProduct;

		allProducts = ProductService.getAll();
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('', '', '');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.getFilteredBy('Type1', 'Family1');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('', 'Type1', 'Family1');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.search('Test3');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('Test3', '', '');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.searchFiltered('Test3', 'Type1', 'Family1');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('Test3', 'Type1', 'Family1');
		for (Product__c product: gotProduct) {
			System.assert(allProducts.contains(product));
		}
	}

	@IsTest
	static void testGetTypesAndFamilies() {
		System.assertEquals(ProductService.getFamilies(), OrderManagementController.getFamilies());
		System.assertEquals(ProductService.getTypes(), OrderManagementController.getTypes());
	}

	@IsTest
	static void testIsUserManager() {
		User user = [SELECT Id, IsManager__c FROM User LIMIT 1];

		System.assertEquals(user.IsManager__c, OrderManagementController.isUserManager(user.Id));
	}

	@IsTest
	static void testCreateProduct() {
		Product__c product =
				new Product__c(Name = 'NAME', Description__c = 'DESC', Type__c = 'Type1', Family__c = 'Family1');
		OrderManagementController.createProduct(product);
		Product__c created =
			[SELECT Name, Description__c, Type__c, Family__c FROM Product__c WHERE Name = 'NAME' LIMIT 1];
		System.assertEquals(product, created);
	}

	@IsTest
	static void testCheckout() {
		insert new Account(Name = 'ACC');
		Account acc = [SELECT Id, Name FROM Account WHERE Name = 'ACC'];

		Product__c[] products = new Product__c[] {
			new Product__c(Name = 'P1',
					Description__c = 'D1',
					Type__c = 'Type1',
					Family__c = 'Family1',
					Image__c = '',
					Price__c = 100
			),
			new Product__c(Name = 'P2',
					Description__c = 'D2',
					Type__c = 'Type1',
					Family__c = 'Family1',
					Image__c = '',
					Price__c = 100
			),
			new Product__c(Name = 'P2',
						Description__c = 'D2',
						Type__c = 'Type1',
						Family__c = 'Family1',
						Image__c = '',
						Price__c = 100
			)
		};

		insert products;

		Product__c[] createdProducts = [SELECT Id, Price__c FROM Product__c WHERE Name in ('P1', 'P2', 'P3')];

		String[] productIds = new String[products.size()];
		for (Integer i = 0; i < products.size(); i++) productIds[i] = products[i].Id;

		OrderManagementController.checkout(createdProducts, acc.Id);

		OrderItem__c[] orderItems = [
				SELECT Id, Quantity__c, Price__c, ProductId__c
				FROM OrderItem__c
		];

		System.assertEquals(products.size(), orderItems.size());
		for (Integer i = 0; i < orderItems.size(); i++) {
			System.assertEquals(productIds[i], String.valueOf(orderItems[i].ProductId__c));
		}
	}
}