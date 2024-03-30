@IsTest
private class ProductServiceTest {

	@IsTest
	static void testGetAll() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
				});

		insert referenceProductList;

		List<Product__c> gotProductList = ProductService.getAll();

		for (Integer i = 0; i < referenceProductList.size(); i++) {
			System.assertEquals(referenceProductList.get(i), gotProductList.get(i));
		}
	}

	@IsTest
	static void testGetByName() {
		String testName = 'Test1';

		Product__c reference = new Product__c(Name = testName, Description__c = 'DESC3');

		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				reference,
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
				});

		insert referenceProductList;

		Product__c got = ProductService.getByName(testName);

		System.assertEquals(reference, got);
	}

	@IsTest
	static void testCreateFromArray() {
		Product__c[] refProducts = new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
				};

		ProductService.create(refProducts);

		List<Product__c> gotProducts =
		[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c];

		for (Integer i = 0; i < refProducts.size(); i++) {
			System.assertEquals(refProducts.get(i), gotProducts.get(i));
		}
	}

	@IsTEst
	static void testDeleteById() {
		Product__c[] refProducts = new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
		};

		insert refProducts;

		Product__c[] beforeProducts = [select Id from Product__c];

		Id refId = beforeProducts.get(0).Id;
		ProductService.deleteById(refId);

		Product__c[] afterProducts = [select Id from Product__c];

		for (Product__c product : afterProducts) {
			System.assertNotEquals(refId, product.Id);
		}
	}

}