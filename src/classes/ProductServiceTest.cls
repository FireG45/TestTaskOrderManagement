@IsTest
private class ProductServiceTest {

	@IsTest
	static void testGetAll() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c {
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

	}

	@IsTest
	static void testCreateRecord() {

	}

}