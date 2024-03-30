public class ProductService {
	public static List<Product__c> getAll() {
		try {
			List<Product__c> products =
			[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c];
			return products;
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static Product__c getByName(String name) {
		try {
			Product__c product =
			[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c
			FROM Product__c WHERE Name = :name];

			return product;
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Product__c product) {
		try {
			insert product;
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static void create(Product__c[] products) {
		try {
			insert products;
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}
}