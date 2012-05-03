package view 
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import view.ui.MainUIView;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TitanMediator extends Mediator 
	{
		public static const NAME:String = "TITAN_MEDIATOR";
		public var ui:Titan;
		
		public var mainUI:MainUIView;
		
		public function TitanMediator(view:Titan) 
		{
			ui = view;
			super(NAME,view);
		}
		
		override public function listNotificationInterests():Array 
		{
			return super.listNotificationInterests();
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			mainUI = new MainUIView;
			var mainUImediator:MainUIMediator = new MainUIMediator(mainUI);
			facade.registerMediator(mainUImediator);
			ui.addChild(mainUI);
		}
	}

}