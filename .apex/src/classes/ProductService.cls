public class ProductService {
	public static List<Product__c> getRecords() {
			List<Product__c> products =
				[SELECT Name, Description__c, Type__c, Family__c, Image__c, Price__c FROM Product__c];
			return products;
	}

	public static void createRecord(Product__c product) {
			insert product;
	}
}