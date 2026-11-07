package manager
{
   public class HtmlUtil
   {
      
      public function HtmlUtil()
      {
         super();
      }
      
      public static function fontBr(content:String, color:String, size:int = 12) : String
      {
         return font(content,color,size) + "\n";
      }
      
      public static function createLink(text:String, bUnderline:Boolean = true, url:String = "My") : String
      {
         var link:String = "";
         if(bUnderline)
         {
            link += "<u>";
            link += "<a href=\'event:" + url + "\'>" + text + "</a>";
            link += "</u>";
         }
         else
         {
            link += "<a href=\'event:" + url + "\'>" + text + "</a>";
         }
         return link;
      }
      
      public static function font(content:String, color:String, size:int = 12) : String
      {
         return "<font color=\'" + color + "\' size=\'" + size + "\'>" + content + "</font>";
      }
      
      public static function link(content:String, event:String) : String
      {
         return "<a href=\'event:" + event + "\'>" + content + "</a>";
      }
      
      public static function underLine(content:String) : String
      {
         return "<u>" + content + "</u>";
      }
      
      public static function fontNoSize(content:String, color:String) : String
      {
         return "<font color=\'" + color + "\'>" + content + "</font>";
      }
      
      public static function br(content:String) : String
      {
         return "<br>" + content + "</br>";
      }
      
      public static function bold(content:String) : String
      {
         return "<b>" + content + "</b>";
      }
      
      public static function filterHtml(content:String) : String
      {
         var result:String = content.replace(/\<\/?[^\<\>]+\>/gmi,"");
         return result.replace(/[\r\n ]+/g,"");
      }
      
      public static function unSize(content:String) : String
      {
         return content.replace(/[sS][iI][zZ][eE](([ ]+=)|=)(([ ]+')|')[0-9]+'/g,"");
      }
      
      public static function unColor(content:String) : String
      {
         return content.replace(/[cC][oO][lL][oO][rR](([ ]+=)|=)(([ ]+')|')#[a-zA-Z0-9]+'/g,"");
      }
   }
}

