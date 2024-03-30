trigger MyHelloWorldTrigger on Account (before insert) {
	MyHelloWorld.addHelloWorld(Trigger.new);
}