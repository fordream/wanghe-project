package model 
{
	import org.puremvc.as3.interfaces.IFacade;
	/**
	 * ...
	 * @author whe
	 */
	public class P 
	{
		
		public function P() 
		{
			throw new Error("静态结构不能构造");
		}
		
		public static var facade:IFacade;
		public static function setFacade(_facade:IFacade):void{
			facade = _facade;
		}
		
	}

}