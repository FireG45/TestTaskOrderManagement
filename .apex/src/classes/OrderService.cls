public class OrderService {
	public static List<Order__c> getAll() {
		try {
			List<Order__c> orderList =
			[SELECT Name, AccountId__c, TotalProductCount__c, TotalPrice__c FROM Order__c];
			return orderList;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static Order__c getByName(String name) {
		try {
			Order__c order =
			[SELECT Name, AccountId__c, TotalProductCount__c, TotalPrice__c FROM Order__c WHERE Name = :name Limit 1];
			return order;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static Order__c getById(Id id) {
		try {
			Order__c order =
			[SELECT Name, AccountId__c, TotalProductCount__c, TotalPrice__c FROM Order__c WHERE Id = :id Limit 1];
			return order;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Order__c order) {
		try {
			insert order;
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Order__c[] orders) {
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
			delete [select Id from Order__c where Id = :id];
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void updateOrder(Order__c order) {
		try {
			update order;
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

}