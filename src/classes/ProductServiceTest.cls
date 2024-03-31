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
	static void testGetFiltered() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1', Type__c = 'Type1', Family__c = 'Family1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4', Type__c = 'Type1', Family__c = 'Family1')
				});

		insert referenceProductList;
		List<Product__c> gotProductList;

		gotProductList = ProductService.getFilteredBy('Type1', '');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Type1', gotProductList.get(i).Type__c);
		}

		gotProductList = ProductService.getFilteredBy('Type3', '');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Type3', gotProductList.get(i).Type__c);
		}

		gotProductList = ProductService.getFilteredBy('', 'Family1');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Family1', gotProductList.get(i).Family__c);
		}

		gotProductList = ProductService.getFilteredBy('', 'Family2');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Family2', gotProductList.get(i).Family__c);
		}
	}

	@IsTest
	static void testGetFilteredEmptyException() {

		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1', Type__c = 'Type1', Family__c = 'Family1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4', Type__c = 'Type1', Family__c = 'Family1')
				});

		insert referenceProductList;

		Boolean throwsEx = false;

		try {
			ProductService.getFilteredBy('', '');
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testSearch() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
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

		insert referenceProductList;
		List<Product__c> gotProductList;

		gotProductList = ProductService.search('Test1');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Test1', gotProductList.get(i).Name);
		}

		gotProductList = ProductService.search('Test2');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('Test2', gotProductList.get(i).Name);
		}

		gotProductList = ProductService.search('DESC');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('DESC', gotProductList.get(i).Description__c);
		}

		gotProductList = ProductService.search('DESC3');
		for (Integer i = 0; i < gotProductList.size(); i++) {
			System.assertEquals('DESC3', gotProductList.get(i).Description__c);
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

	@IsTest
	static void testCreate() {
		Product__c refProduct = new Product__c(Name = 'Test1', Description__c = 'DESC1');

		ProductService.create(refProduct);

		List<Product__c> gotProducts =
		[SELECT Name, Description__c FROM Product__c];

		System.assert(gotProducts.contains(refProduct));
	}

	@IsTest
	static void testCreateDuplicateException() {

		insert new Product__c(Name = 'Test1', Description__c = 'DESC1');

		Product__c refProduct =
		[SELECT Id FROM Product__c][0];

		Boolean throwsEx = false;

		try {
			ProductService.create(refProduct);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
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

	@IsTest
	static void testUpdate() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
				});

		insert referenceProductList;

		Product__c product =
		[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c
		FROM Product__c LIMIT 1];
		Id refId = product.Id;

		product.Name = 'UPDATED';
		ProductService.updateProduct(product);

		Product__c afterUpdate =
		[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c WHERE Id = :refId LIMIT 1];

		System.assertEquals('UPDATED', afterUpdate.Name);
	}

	@IsTest
	static void testUpdateEmptyException() {
		List<Product__c> referenceProductList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4')
		});

		insert referenceProductList;

		Product__c product = new Product__c();

		Boolean throwsEx = false;

		try {
			ProductService.updateProduct(product);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testGetTypes() {
		Schema.DescribeFieldResult fieldDescription = Product__c.Type__c.getDescribe();
		List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();

		List<String> types = ProductService.getTypes();

		for (Integer i = 0; i < entries.size(); i++) {
			System.assertEquals(entries[i].getLabel(), types.get(i));
		}
	}

	@IsTest
	static void testGetFamilies() {
		Schema.DescribeFieldResult fieldDescription = Product__c.Family__c.getDescribe();
		List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();

		List<String> families = ProductService.getFamilies();

		for (Integer i = 0; i < entries.size(); i++) {
			System.assertEquals(entries[i].getLabel(), families.get(i));
		}
	}
}