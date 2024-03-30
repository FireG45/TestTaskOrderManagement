@IsTest
private class OrderServiceTest {

	private static Account account1 = new Account(Name = 'Acc1');
	private static Account account2 = new Account(Name = 'Acc2');

	private static Order__c[] refOrders = new Order__c[] {
			new Order__c(Name = 'Order1', AccountId__c = account1.Id, TotalProductCount__c = 0, TotalPrice__c = 0),
			new Order__c(Name = 'Order2', AccountId__c = account2.Id, TotalProductCount__c = 0, TotalPrice__c = 0),
			new Order__c(Name = 'Order3', AccountId__c = account1.Id, TotalProductCount__c = 0, TotalPrice__c = 0),
			new Order__c(Name = 'Order4', AccountId__c = account2.Id, TotalProductCount__c = 0, TotalPrice__c = 0),
			new Order__c(Name = 'Order5', AccountId__c = account1.Id, TotalProductCount__c = 0, TotalPrice__c = 0)
			};

	@TestSetup
	static void init() {
		insert account1;
		insert account2;
		insert refOrders;
	}

	@IsTest
	static void testGetAll() {
		List<Order__c> gotOrders = OrderService.getAll();

		for (Integer i = 0; i < refOrders.size(); i++) {
			System.assertEquals(refOrders.get(i).Name, gotOrders.get(i).Name);
		}
	}

	@IsTest
	static void testGetById() {
		Order__c refOrder = [SELECT Name, AccountId__c, TotalProductCount__c, TotalPrice__c FROM Order__c Limit 1];

		Id refId = refOrder.Id;

		Order__c gotOrder = OrderService.getById(refId);
		System.assertEquals(refOrder, gotOrder);
	}

	@IsTest
	static void testCreate() {
		Account account1 = new Account(Name = 'Acc1');
		Order__c refOrder =
				new Order__c(
						Name = 'TestOrder1',
						AccountId__c = account1.Id,
						TotalProductCount__c = 0,
						TotalPrice__c = 0
				);
		OrderService.create(refOrder);

		Order__c gotOrder =
		[select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c WHERE Name = :refOrder.Name];
		System.assertEquals(refOrder.Name, gotOrder.Name);
	}

	@IsTest
	static void testCreateFromArray() {
		Account account1 = new Account(Name = 'Acc1');
		Order__c[] referenceOrders = new Order__c[] {
				new Order__c(
						Name = 'TestOrder1',
						AccountId__c = account1.Id,
						TotalProductCount__c = 0,
						TotalPrice__c = 0
				),
				new Order__c(
						Name = 'TestOrder2',
						AccountId__c = account1.Id,
						TotalProductCount__c = 0,
						TotalPrice__c = 0
				),
				new Order__c(
						Name = 'TestOrder3',
						AccountId__c = account1.Id,
						TotalProductCount__c = 0,
						TotalPrice__c = 0
				),
				new Order__c(
						Name = 'TestOrder4',
						AccountId__c = account1.Id,
						TotalProductCount__c = 0,
						TotalPrice__c = 0
				)
				};

		OrderService.create(referenceOrders);

		for (Integer i = 0; i < referenceOrders.size(); i++) {
			Order__c order = [select Name from Order__c where Name = :referenceOrders[i].name];
			System.assertEquals(referenceOrders[i].Name, order.Name);
		}
	}

	@IsTest
	static void testCreateNullException() {
		Order__c refOrder = null;

		Boolean throwsEx = false;

		try {
			OrderService.create(refOrder);
		} catch (HandledException ex) {
			throwsEx = ex.getMessage() != null;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testCreateNullExceptionFromArray() {
		Order__c[] referenceOrders = new Order__c[] {
				null,
				null,
				null,
				null
				};

		Boolean throwsEx = false;

		try {
			OrderService.create(referenceOrders);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testDeleteById() {
		Order__c refOrder = [select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c Limit 1];
		Id refId = refOrder.Id;

		OrderService.deleteById(refId);

		Order__c[] orders = [select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c];
		System.assert(!orders.contains(refOrder));
	}

	@IsTest
	static void testUpdate() {
		Order__c refOrder = [select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c Limit 1];
		Id refId = refOrder.Id;

		refOrder.Name = 'UPDATED';

		OrderService.updateOrder(refOrder);

		Order__c updatedOrder =
		[select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c WHERE Id = :refId Limit 1];

		System.assertEquals('UPDATED', updatedOrder.Name);
	}

	@IsTest
	static void testUpdateDontExistException() {
		Order__c refOrder = [select Name, AccountId__c, TotalProductCount__c, TotalPrice__c from Order__c Limit 1];

		delete refOrder;

		Boolean throwsEx = false;

		try {
			OrderService.updateOrder(refOrder);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}
}