public class OrderItemService {

	public static List<OrderItem__c> getAll() {
		try {
			List<OrderItem__c> orderItemList =
			[SELECT Id, Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c];

			return orderItemList;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static OrderItem__c getById(Id id) {
		try {
			OrderItem__c orderItem =
			[SELECT Name, OrderId__c, ProductId__c, Quantity__c, Price__c FROM OrderItem__c WHERE Id = :id Limit 1];
			return orderItem;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(OrderItem__c order) {
		Set<Type> exList = new Set<Type> { DmlException.class, NullPointerException.class };

		try {
			insert order;
		} catch (Exception e) {
			if (!exList.contains(Type.forName(e.getTypeName())))
				throw e;

			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(OrderItem__c[] orders) {
		Set<Type> exList = new Set<Type> { DmlException.class, ListException.class };
		try {
			insert orders;
		} catch (Exception e) {
			if (!exList.contains(Type.forName(e.getTypeName()))) throw e;

			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void deleteById(Id id) {
		try {
			delete [select Id from OrderItem__c where Id = :id];
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void updateOrder(OrderItem__c order) {
		try {
			update order;
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}
	
}