package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.LangConfig;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class TianFu_Item extends Sprite
   {
      
      private var titleTF:MyTextField;
      
      private var contentTF:MyTextField;
      
      private var tipTF:MyTextField;
      
      private var bgTF:MyTextField;
      
      private var level:int;
      
      public function TianFu_Item()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.creatTF();
      }
      
      private function creatTF() : void
      {
         this.titleTF = ComponentUtil.getTextField(LangConfig.getWord("80073",8),this,{
            "x":124 - 48,
            "y":0,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.titleTF.align = "center";
         this.bgTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":30,
            "leading":8,
            "color":11904647
         });
         this.bgTF.multiline = true;
         this.bgTF.htmlText = LangConfig.getWord("80074",8);
         this.contentTF = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":30,
            "leading":8
         });
         this.contentTF.multiline = true;
         this.tipTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":170 / 2 - 20,
            "size":16
         });
      }
      
      public function show(vec:Vector.<Vo_TianMing>, level:int) : void
      {
         var str:String = null;
         var typeDic:Dictionary = null;
         var vo:Vo_TianMing = null;
         var i:String = null;
         var levelStr:int = 0;
         var addValue:Number = NaN;
         this.contentTF.htmlText = "";
         this.level = level;
         if(level > Enum_TianMing.TIANFU_MAXLEVEL)
         {
            this.changVis(false);
            this.tipTF.htmlText = "<font color=\'#ff0000\'>" + LangConfig.getWord("80108",8) + "</font>";
         }
         else
         {
            this.changVis(true);
            this.titleTF.htmlText = "<font color = \'#FF6600\'>" + LangConfig.getWord("80073",8) + "(" + level + ")</font>";
            typeDic = Data_lib.attribute;
            for(i in vec)
            {
               vo = vec[i];
               if(vo == null)
               {
                  break;
               }
               if(vo.lock)
               {
                  levelStr = int(Enum_TianMing.OPEN_LEVEL[i]);
                  str = LangConfig.getWord("80117",8,levelStr);
               }
               else if(vo.id != 0)
               {
                  if(level == 0)
                  {
                     str = "<font color=\'#0099FF\'>" + typeDic[vo.type_result][0] + ":" + vo.value + "</font>";
                  }
                  else
                  {
                     addValue = Math.ceil(Data_lib.tmsx[level][2] / 100 * vo.value);
                     str = "<font color=\'#0099FF\'>" + typeDic[vo.type_result][0] + ":" + vo.value + "</font><font color=\'#FF9900\'>(+" + addValue + ")</font>";
                  }
               }
               else
               {
                  str = "<font color=\'#FF0000\'>" + LangConfig.getWord("80076",8) + "</font>";
               }
               this.contentTF.htmlText += str + "<br>";
            }
         }
      }
      
      private function changVis(value:Boolean) : void
      {
         this.titleTF.visible = this.bgTF.visible = this.contentTF.visible = value;
         this.tipTF.visible = !value;
      }
   }
}

