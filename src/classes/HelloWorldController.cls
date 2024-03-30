public class HelloWorldController {
	@AuraEnabled
	public static String getHello(String name) {
		return 'Hello, ' + name;
	}
}