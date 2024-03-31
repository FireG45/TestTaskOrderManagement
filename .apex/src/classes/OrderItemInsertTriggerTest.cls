@IsTest
private class OrderItemInsertTriggerTest {
	@IsTest
	static void testOrderItemInsert() {
		insert new Account(Name = 'TEST');
		Account account = [SELECT Id FROM Account WHERE Name = 'TEST'];
		insert new Order__c(Name = 'TEST', AccountId__c = account.Id, TotalProductCount__c = 0, TotalPrice__c = 0);
		Order__c order = [SELECT Id, Name, AccountId__c, TotalProductCount__c, TotalPrice__c  FROM Order__c WHERE Name = 'TEST'];
		insert new Product__c(Name = 'TEST', Price__c = 100);
		Product__c product = [SELECT Id, Price__c FROM Product__c WHERE Name = 'TEST'];

		OrderItem__c[] orderItems = new OrderItem__c[] {
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product.Id,
						Quantity__c = 1,
						Price__c = product.Price__c),
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product.Id,
						Quantity__c = 1,
						Price__c = product.Price__c),
				new OrderItem__c(
						OrderId__c = order.Id,
						ProductId__c = product.Id,
						Quantity__c = 1,
						Price__c = product.Price__c)
				};

		insert orderItems;

		Integer refQuantity = orderItems.size();
		Integer refPrice = (Integer)(product.Price__c * refQuantity);

		Order__c afterInsertOrder = [SELECT Id, TotalPrice__c, TotalProductCount__c FROM Order__c WHERE Name = 'TEST'];

		System.assertEquals(refPrice, afterInsertOrder.TotalPrice__c);
		System.assertEquals(refQuantity, afterInsertOrder.TotalProductCount__c);
	}
}