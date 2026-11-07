package com.yiTian.view.modules.blueDiamondND.xiaofeiCJ
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.view.modules.blueDiamondND.ViewBlueDiamondNDPanel;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Model_xiaoFeiCJ
   {
      
      private static var _str:String;
      
      private static var containSpr:Sprite;
      
      private static var tf:MyTextField;
      
      private static var panDic:Dictionary = new Dictionary();
      
      public static var XFSTR:String = "Title_xiaofei";
      
      public static var LZSTR:String = "Title_LZDZP";
      
      public static var XFSTR2:String = "Title_xiaofei2";
      
      public static var XFZP:String = "Title_XFZP";
      
      public static var XYZH:String = "Title_XYZH";
      
      public function Model_xiaoFeiCJ()
      {
         super();
      }
      
      public static function cjPan(str:String) : ViewBlueDiamondNDPanel
      {
         if(!panDic[str])
         {
            panDic[str] = new ViewBlueDiamondNDPanel();
            panDic[str].init();
         }
         return panDic[str];
      }
      
      public static function get descrip() : String
      {
         if(!_str)
         {
            _str = "转转次数：{0}次\n全服限购：全服" + "<font color=\'#04ff00\'>" + "仅限转50000次" + "</font>" + "，转完不增加转转次数\n转转规则：" + "活动期间，" + "<font color=\'#04ff00\'>" + "在本页面" + "</font>" + "续费蓝钻或年费蓝钻。可获得一次转转机会，" + "<font color=\'#04ff00\'>" + "最多获得12次" + "</font>" + "，转转机会可能延迟\n" + "<font color=\'#04ff00\'>" + "特别提示：续费最短一个月可以获得一次转转机会" + "</font>";
         }
         return _str;
      }
      
      private static function get btnStrArr() : Array
      {
         return ["openBlueBtn","Button_GHYKT"];
      }
      
      public static function addBlueUnit(_parent:DisplayObjectContainer) : void
      {
         var onClick:Function;
         var i:int = 0;
         var s:String = null;
         var btn:Button = null;
         if(!containSpr)
         {
            onClick = function(e:MouseEvent):void
            {
               var btns:Button = e.target as Button;
               if(!btns)
               {
                  return;
               }
               if(btns.name == "Button_GHYKT")
               {
                  View_hzTribute.sendType = "send";
               }
               else
               {
                  View_hzTribute.sendType = "self";
               }
               YellowDiaManager.buy();
            };
            containSpr = new Sprite();
            _parent.addChild(containSpr);
            ComponentUtil.setPropertie(containSpr,{
               "x":396,
               "y":282
            });
            tf = ComponentUtil.getTextField("",containSpr,{
               "y":-3,
               "realWidth":315,
               "realHeight":100,
               "multiline":true,
               "wordWrap":true,
               "leading":3
            });
            i = 0;
            while(i < 2)
            {
               s = btnStrArr[i];
               btn = ComponentUtil.getButton("",s,containSpr,{
                  "x":150 * i,
                  "y":83,
                  "tabIndex":i + 1,
                  "textColor":16383744
               },ComponentUtil.domain);
               var _temp_1:* = btn;
               btn.scaleY = 0.8;
               _temp_1.scaleX = 0.8;
               btn.name = s;
               btn.addEventListener(MouseEvent.CLICK,onClick);
               i++;
            }
         }
      }
      
      public static function updateQQGameType(times:int) : void
      {
         tf.htmlText = descrip.replace("{0}",times);
      }
   }
}

