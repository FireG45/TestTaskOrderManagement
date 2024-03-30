public class ProductService {
	public static List<Product__c> getAll() {
		try {
			List<Product__c> products =
			[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c];
			return products;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static Product__c getByName(String name) {
		try {
			Product__c product =
			[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c
			FROM Product__c WHERE Name = :name LIMIT 1];

			return product;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Product__c product) {
		try {
			insert product;
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Product__c[] products) {
		try {
			insert products;
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void deleteById(Id id) {
		try {
			delete [select Id from Product__c where Id = :id];
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void updateProduct(Product__c product) {
		try {
			update product;
		} catch (DmlException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}
}