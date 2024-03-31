
@IsTest
private class OrderItemServiceTest {

	private static Account account1 = new Account(Name = 'Acc1');
	private static Order__c order;
	private static Product__c product1 = new Product__c(Name = 'Product1', Price__c = 100);
	private static Product__c product2 = new Product__c(Name = 'Product2', Price__c = 200);

	private static List<OrderItem__c> refOrderItems = new List<OrderItem__c> {
			new OrderItem__c(OrderId__r = order, ProductId__r = product1, Quantity__c = 1),
			new OrderItem__c(OrderId__r = order, ProductId__r = product2, Quantity__c = 2),
			new OrderItem__c(OrderId__r = order, ProductId__r = product1, Quantity__c = 1),
			new OrderItem__c(OrderId__r = order, ProductId__r = product2, Quantity__c = 2),
			new OrderItem__c(OrderId__r = order, ProductId__r = product1, Quantity__c = 1)
	};

	@TestSetup
	static void init() {
		insert account1;

		account1 = [select Id, Name from Account WHERE Name = 'Acc1' limit 1];

		insert new Order__c(
				Name = 'Order1',
				AccountId__c = account1.Id,
				TotalPrice__c = 0,
				TotalProductCount__c = 0);
		insert product1;
		insert product2;

		order = [select Id, Name from Order__c where Name = 'Order1' limit 1];
		product1 = [select Id, Name from Product__c where Name = 'Product1' limit 1];
		product2 = [select Id, Name from Product__c where Name = 'Product2' limit 1];

		List<OrderItem__c> refOrderItems = new List<OrderItem__c> {
				new OrderItem__c(OrderId__c = order.Id, ProductId__c = product1.Id, Quantity__c = 1, Price__c = 100),
				new OrderItem__c(OrderId__c = order.Id, ProductId__c = product2.Id, Quantity__c = 2, Price__c = 100),
				new OrderItem__c(OrderId__c = order.Id, ProductId__c = product1.Id, Quantity__c = 1, Price__c = 100),
				new OrderItem__c(OrderId__c = order.Id, ProductId__c = product2.Id, Quantity__c = 2, Price__c = 100),
				new OrderItem__c(OrderId__c = order.Id, ProductId__c = product1.Id, Quantity__c = 1, Price__c = 100)
		};

		insert refOrderItems;
	}

	@IsTest
	static void testGetAll() {
		List<OrderItem__c> gotOrders = OrderItemService.getAll();

		refOrderItems = [SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c];

		for (Integer i = 0; i < refOrderItems.size(); i++) {
			System.assertEquals(refOrderItems.get(i).OrderId__c, gotOrders.get(i).OrderId__c);
			System.assertEquals(refOrderItems.get(i).ProductId__c, gotOrders.get(i).ProductId__c);
		}
	}

	@IsTest
	static void testGetById() {
		OrderItem__c refOrderItem =
		[SELECT OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c Limit 1];

		Id refId = refOrderItem.Id;

		OrderItem__c gotOrder = OrderItemService.getById(refId);
		System.assertEquals(refOrderItem.Id, gotOrder.Id);
	}

	@IsTest
	static void testCreate() {
		order = [select Id, Name from Order__c where Name = 'Order1' limit 1];
		product1 = [select Id, Name from Product__c where Name = 'Product1' limit 1];

		OrderItem__c refOrder =
				new OrderItem__c(
						Name = 'NAME',
						OrderId__c = order.Id,
						ProductId__c = product1.Id,
						Quantity__c = 1,
						Price__c = 100
				);

		OrderItemService.create(refOrder);

		OrderItem__c gotOrder =
		[SELECT Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c WHERE Name = 'NAME' LIMIT 1];
		System.assertEquals(refOrder.OrderId__c, gotOrder.OrderId__c);
		System.assertEquals(refOrder.ProductId__c, gotOrder.ProductId__c);
	}

	@IsTest
	static void testCreateFromArray() {
		order = [select Id, Name from Order__c where Name = 'Order1' limit 1];
		product1 = [select Id, Name from Product__c where Name = 'Product1' limit 1];
		product2 = [select Id, Name from Product__c where Name = 'Product2' limit 1];

		OrderItem__c[] referenceOrderItems = new OrderItem__c[] {
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product1.Id,
						Quantity__c = 1,
						Price__c = 100
				),
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product1.Id,
						Quantity__c = 1,
						Price__c = 100
				),
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product1.Id,
						Quantity__c = 1,
						Price__c = 100
				),
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product1.Id,
						Quantity__c = 1,
						Price__c = 100
				)
		};

		OrderItemService.create(referenceOrderItems);

		for (Integer i = 0; i < referenceOrderItems.size(); i++) {
			OrderItem__c orderItems =
			[select OrderId__c, ProductId__c from OrderItem__c
				where OrderId__c = :referenceOrderItems[i].OrderId__c Limit 1];
			System.assertEquals(referenceOrderItems[i].OrderId__c, orderItems.OrderId__c);
			System.assertEquals(referenceOrderItems[i].ProductId__c, orderItems.ProductId__c);
		}
	}

	@IsTest
	static void testCreateEmptyException() {
		OrderItem__c refOrder = new OrderItem__c();

		Boolean throwsEx = false;

		try {
			OrderItemService.create(refOrder);
		} catch (HandledException ex) {
			throwsEx = ex.getMessage() != null;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testCreateNullExceptionFromArray() {
		OrderItem__c[] referenceOrders = new OrderItem__c[] {
				null,
				null,
				null,
				null
		};

		Boolean throwsEx = false;

		try {
			OrderItemService.create(referenceOrders);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testCreateEmptyExceptionFromArray() {
		OrderItem__c[] referenceOrders = new OrderItem__c[] {
				new OrderItem__c(),
				new OrderItem__c(),
				new OrderItem__c(),
				new OrderItem__c()
		};

		Boolean throwsEx = false;

		try {
			OrderItemService.create(referenceOrders);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}

	@IsTest
	static void testDeleteById() {
		OrderItem__c refOrderItem =
		[SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c Limit 1];

		Id refId = refOrderItem.Id;

		OrderItemService.deleteById(refId);

		OrderItem__c[] orders = [SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c];
		System.assert(!orders.contains(refOrderItem));
	}

	@IsTest
	static void testUpdate() {
		OrderItem__c refOrder =
		[SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c Limit 1];

		Id refId = refOrder.Id;

		refOrder.Quantity__c = 500;

		OrderItemService.updateOrder(refOrder);

		OrderItem__c updatedOrder =
		[SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c WHERE Id = :refId Limit 1];

		System.assertEquals(500, updatedOrder.Quantity__c);
	}

	@IsTest
	static void testUpdateDontExistException() {
		OrderItem__c refOrder =
		[SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c Limit 1];

		delete refOrder;

		Boolean throwsEx = false;

		try {
			OrderItemService.updateOrder(refOrder);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);
	}
	
}