package manager
{
   import flash.utils.Dictionary;
   
   public class ResourceVersionConfig
   {
      
      public static var urlDic:Dictionary;
      
      public static var isRelease:Boolean = true;
      
      public function ResourceVersionConfig()
      {
         super();
      }
      
      public static function initialize() : void
      {
         urlDic = new Dictionary();
         if(isRelease == true)
         {
            urlDic["lang/ch/words"] = 8;
            urlDic["lang/ch/Create.swf"] = 3;
            urlDic["lang/ch/createButton.swf"] = 1;
            urlDic["lang/ch/createNew.swf"] = 1;
            urlDic["lang/ch/child_creat.swf"] = 2;
            urlDic["lang/ch/guideMM.swf"] = 3;
            urlDic["resource/image/logo/loading.swf"] = 4;
            urlDic["resource/image/logo/di3.jpg"] = 1;
            urlDic["resource/image/shareIcon/shareIcon.png"] = 1;
            urlDic["modelRes/magic/35050.swf"] = 1;
         }
      }
   }
}

