public class ProductService {
	public static List<Product__c> getAll() {
		try {
			List<Product__c> products =
			[SELECT Id, Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c];
			return products;
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static List<Product__c> getFilteredBy(String type, String family) {
		try {
			if (type.length() == 0 && family.length() == 0) throw new QueryException('Empty Filters!');
			return [
					SELECT Id, Name, Description__c, Type__c, Family__c, Image__c, Price__c
					FROM Product__c
					WHERE Type__c = :type OR Family__c = :family
			];
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static List<Product__c> search(String query) {
		try {
			return [
					SELECT Id, Name, Description__c, Type__c, Family__c, Image__c, Price__c
					FROM Product__c
					WHERE Name Like :query Or Description__c Like :query
			];
		} catch (QueryException e) {
			System.debug(LoggingLevel.ERROR, e.getMessage());
			throw new HandledException(e.getMessage());
		}
	}

	public static List<Product__c> searchFiltered(String query, String type, String family) {
		try {
			return [
					SELECT Id, Name, Description__c, Type__c, Family__c, Image__c, Price__c
					FROM Product__c
					WHERE
					(Name Like :query Or Description__c Like :query)
					AND
					(Type__c = :type OR Family__c = :family)
			];
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

	public static List<String> getTypes() {
		Schema.DescribeFieldResult fieldDescription = Product__c.Type__c.getDescribe();
		List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();

		List<String> names = new List<String>();

		for (Schema.PicklistEntry entry : entries) {
			names.add(entry.getLabel());
		}

		return names;
	}

	public static List<String> getFamilies() {
		Schema.DescribeFieldResult fieldDescription = Product__c.Family__c.getDescribe();
		List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();

		List<String> names = new List<String>();

		for (Schema.PicklistEntry entry : entries) {
			names.add(entry.getLabel());
		}

		return names;
	}
}