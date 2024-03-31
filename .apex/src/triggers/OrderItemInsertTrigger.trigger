trigger OrderItemInsertTrigger on OrderItem__c (before insert) {
	System.debug(Trigger.new);
	for (OrderItem__c o : Trigger.new) {
		System.debug(o);
		Order__c order = [
				SELECT Id, Name, AccountId__c, TotalProductCount__c, TotalPrice__c
				FROM Order__c
				WHERE Id = :o.OrderId__c
		];
		System.debug(order);
		order.TotalPrice__c += o.Price__c * o.Quantity__c;
		order.TotalProductCount__c += o.Quantity__c;
		update order;
	}
}