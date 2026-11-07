package
{
   import flash.display.Stage;
   
   public class Global
   {
      
      public static var heroId:Number;
      
      public static var key:int;
      
      public static var stage:Stage;
      
      public static var account:String;
      
      public static var fcm:int;
      
      public static var openkey:String;
      
      public static var _pf:String;
      
      public static var fpkey:String;
      
      public static var invkey:String;
      
      public static var itime:String;
      
      public static var iopenid:String;
      
      public static var zoneid:String;
      
      public static var via:String;
      
      public static var user_source:String;
      
      public static var contract_id:String;
      
      public static var app_custom:String;
      
      public static var fd:String;
      
      public static var seqid:String;
      
      public static var dengluQuHao:int;
      
      public static var QQGameZKJ:Boolean;
      
      public static var jinJuanStore:Boolean;
      
      public static var adtag:String;
      
      public static var randJob:int;
      
      public static var createDm:*;
      
      public static var loadBack:*;
      
      public static var config:Object = new Object();
      
      public static var isUsingNewCreateScene:Boolean = true;
      
      public static var loadBackUrl:String = "jiaodianPic/loadBack.swf";
      
      public function Global()
      {
         super();
      }
      
      public static function set pf(value:String) : void
      {
         _pf = value;
      }
      
      public static function get pf() : String
      {
         if(_pf.indexOf("*") == -1)
         {
            return _pf;
         }
         var _a:Array = _pf.split("*");
         return _a[1];
      }
   }
}

