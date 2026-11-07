package com.yiTian.view.modules.cast
{
   import com.event.Button_h;
   import com.event.TabButton_h;
   import com.event.TextField_h;
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScrollBar;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strUI;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool_delete;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class View_cast_base extends Sprite
   {
      
      protected static var i:int;
      
      protected static var btn_ok:Button_h;
      
      protected static var tbtn_stuff:TabButton;
      
      protected static var tbbtn_bought:TabButton;
      
      protected static var tf_help:MyTextField;
      
      protected static var callBack_changeFilter:Function;
      
      protected static var callBack_btn_ok:Function;
      
      protected static var canvas_up:Canvas;
      
      protected static var canvas_down:Canvas;
      
      protected static var canvas_down_quickMetia:Canvas;
      
      protected static var metiaContainer:Sprite;
      
      protected static var canvas_txt:Canvas;
      
      protected static var filter:int;
      
      protected static var pool:Pool_delete;
      
      protected static var vec_Vo_valuable_cache:Vector.<Vo_valuable>;
      
      protected static var vec_Vo_valuable_show_up:Vector.<Vo_valuable>;
      
      protected static var vec_Vo_valuable_show_down:Vector.<Vo_valuable>;
      
      protected static var vec_View_grid_extra_up:Vector.<View_grid_extra>;
      
      protected static var vec_View_grid_extra_down:Vector.<View_grid_extra>;
      
      protected static var vec_View_grid_extra_down_quickData:Vector.<View_grid_extra>;
      
      private static var tf_tip:TextField_h;
      
      private static var tbtn_now:TabButton_h;
      
      private static var vec_tbtn:Vector.<TabButton_h>;
      
      public static var DATA_LENG:int;
      
      protected static var tfMiJing:MyTextField;
      
      protected static var tfMart:MyTextField;
      
      private static var changeNow:TabButton;
      
      private static const ARR_STR:Array = [LangConfig.getWord("145",0),LangConfig.getWord("146",0)];
      
      private static const ARR_STR_ZUOQI:Array = [LangConfig.getWord("147",0),LangConfig.getWord("148",0)];
      
      private static const COUNT:int = 2;
      
      private static const Y_TabButton:int = 45;
      
      protected static const INDENT:int = 5;
      
      protected static const GAP_WIDTH_GRID:int = 3;
      
      protected static const GAP_HEIGHT_GRID:int = 3;
      
      protected static const WIDTH_GRID:int = 120;
      
      protected static const HEIGHT_GRID:int = 42;
      
      public static var GAP_X:int = 7;
      
      public static var GAP_XL:int = 140;
      
      protected var dis_bg:DisplayObject;
      
      public function View_cast_base()
      {
         super();
         if(this["constructor"] == View_cast_base)
         {
            throw new Error("抽象类不能直接new");
         }
      }
      
      public static function Init_static(container:DisplayObjectContainer) : void
      {
         tbtn_stuff = ComponentUtil.getTabButton("","TabButton_Four",container,{
            "x":395,
            "y":245,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"metia"
         },Global.Img_Cdm);
         tbbtn_bought = ComponentUtil.getTabButton("快速购买","TabButton_Four",container,{
            "x":470,
            "y":245,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"quick"
         },Global.Img_Cdm);
         tbtn_stuff.visible = false;
         tbbtn_bought.visible = false;
         tbtn_stuff.choose = true;
         changeNow = tbtn_stuff;
         tbtn_stuff.addEventListener(MouseEvent.CLICK,changeHd);
         tbbtn_bought.addEventListener(MouseEvent.CLICK,changeHd);
         tfMiJing = ComponentUtil.getTextField("",container,{
            "x":517 + 90,
            "y":247
         });
         tfMart = ComponentUtil.getTextField("",container,{
            "x":557 + 90,
            "y":247
         });
         tfMiJing.htmlText = HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine("秘境"),"#ff7700"),"sm");
         tfMart.htmlText = HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine("市场"),"#ff7700"),"mart");
         tfMart.mouseEnabled = true;
         tfMiJing.mouseEnabled = true;
         tfMart.addEventListener(TextEvent.LINK,link);
         tfMiJing.addEventListener(TextEvent.LINK,link);
         tfMart.visible = false;
         tfMiJing.visible = false;
         tf_tip = ComponentUtil.getTextField_h("",container,{
            "x":112,
            "y":455
         });
         filter = Enum_filter.ALL;
         pool = new Pool_delete(View_grid_extra);
         vec_View_grid_extra_up = new Vector.<View_grid_extra>();
         vec_View_grid_extra_down = new Vector.<View_grid_extra>();
         vec_View_grid_extra_down_quickData = new Vector.<View_grid_extra>();
         vec_Vo_valuable_show_up = new Vector.<Vo_valuable>();
         vec_Vo_valuable_show_down = new Vector.<Vo_valuable>();
         canvas_txt = new Canvas(218,100);
         canvas_txt.x = 100;
         canvas_txt.y = 389;
         canvas_txt.scrollAutoType = ScrollAutoType.REMAIN;
         container.addChild(canvas_txt);
         tf_help = ComponentUtil.getTextField("",container,{
            "x":2,
            "y":-2,
            "leading":3
         });
         tf_help.width = 222 - ScrollBar.WIDTH - 2;
         tf_help.wordWrap = true;
         canvas_txt.addChild(tf_help);
         metiaContainer = new Sprite();
         canvas_up = new Canvas(281,175,"RIGHT",2);
         canvas_up.x = 393;
         canvas_up.y = 66;
         canvas_up.scrollAutoType = ScrollAutoType.REMAIN;
         container.addChild(canvas_up);
         canvas_down = new Canvas(281,176,"RIGHT",2);
         canvas_down.x = 393;
         canvas_down.y = 267;
         canvas_down.scrollAutoType = ScrollAutoType.REMAIN;
         container.addChild(canvas_down);
         canvas_down_quickMetia = new Canvas(295,173);
         canvas_down_quickMetia.x = 393;
         canvas_down_quickMetia.y = 269;
         canvas_down_quickMetia.scrollAutoType = ScrollAutoType.REMAIN;
         container.addChild(canvas_down_quickMetia);
         canvas_down_quickMetia.visible = false;
      }
      
      private static function link(e:TextEvent) : void
      {
         trace(e.text);
         switch(e.text)
         {
            case "sm":
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("904",0));
                  return;
               }
               UIManager.sm_shop.visible = !UIManager.sm_shop.visible;
               break;
            case "mart":
               UIManager.smallMap.shiClick();
         }
      }
      
      private static function changeHd(e:MouseEvent) : void
      {
         var tab:TabButton = e.target as TabButton;
         var st:String = tab.name;
         if(changeNow == tab)
         {
            return;
         }
         if(Boolean(changeNow))
         {
            changeNow.choose = false;
         }
         tab.choose = true;
         changeNow = tab;
         switch(st)
         {
            case "metia":
               canvas_down.visible = true;
               canvas_down_quickMetia.visible = false;
               break;
            case "quick":
               canvas_down.visible = false;
               canvas_down_quickMetia.visible = true;
         }
      }
      
      private static function CLICK_TBTN(e:MouseEvent) : void
      {
         var tbtn:TabButton_h = e.target as TabButton_h;
         if(tbtn_now == tbtn)
         {
            return;
         }
         if(Boolean(tbtn_now))
         {
            tbtn_now.bDown = false;
         }
         canvas_up.reset();
         canvas_down.reset();
         tbtn_now = tbtn;
         tbtn.bDown = true;
         if(tbtn.tabIndex == 0)
         {
            filter = Enum_filter.ALL;
         }
         else if(tbtn.tabIndex == 1)
         {
            filter = Enum_filter.WHITE;
         }
         else if(tbtn.tabIndex == 2)
         {
            filter = Enum_filter.GREEN;
         }
         else if(tbtn.tabIndex == 3)
         {
            filter = Enum_filter.BLUE;
         }
         else if(tbtn.tabIndex == 4)
         {
            filter = Enum_filter.PUPLE;
         }
         callBack_changeFilter();
      }
      
      private static function CLICK_BTN_OK(e:MouseEvent) : void
      {
         callBack_btn_ok(e);
      }
      
      public function init_dynamic(container:DisplayObjectContainer, add_count_index:int) : void
      {
         var tbtn:TabButton_h = null;
         var i:int = 0;
         if(add_count_index == 5 || add_count_index == 6)
         {
            vec_tbtn = new Vector.<TabButton_h>(1,true);
            i = 0;
            while(i < 1)
            {
               tbtn = ComponentUtil.getTabButton_h(LangConfig.getWord("149",0),Const_strUI.TBTN_FOUR,true,true,container,{
                  "x":340 + i * 72,
                  "y":Y_TabButton
               });
               tbtn.addEventListener(MouseEvent.CLICK,CLICK_TBTN);
               tbtn.tabIndex = i;
               vec_tbtn[i] = tbtn;
               i++;
            }
         }
         else if(add_count_index == 7)
         {
            vec_tbtn = new Vector.<TabButton_h>(COUNT,true);
            i = 0;
            while(i < COUNT)
            {
               tbtn = ComponentUtil.getTabButton_h(ARR_STR_ZUOQI[i],Const_strUI.TBTN_FOUR,true,true,container,{
                  "x":340 + i * 72,
                  "y":Y_TabButton
               });
               tbtn.addEventListener(MouseEvent.CLICK,CLICK_TBTN);
               tbtn.tabIndex = i;
               vec_tbtn[i] = tbtn;
               i++;
            }
         }
         else
         {
            vec_tbtn = new Vector.<TabButton_h>(COUNT,true);
            i = 0;
            while(i < COUNT)
            {
               tbtn = ComponentUtil.getTabButton_h(ARR_STR[i],Const_strUI.TBTN_FOUR,true,true,container,{
                  "x":340 + i * 72,
                  "y":Y_TabButton
               });
               tbtn.addEventListener(MouseEvent.CLICK,CLICK_TBTN);
               tbtn.tabIndex = i;
               vec_tbtn[i] = tbtn;
               i++;
            }
         }
         tbtn_now = vec_tbtn[0];
         tbtn_now.bDown = true;
      }
      
      public function Init() : void
      {
         throw new Error("抽象方法");
      }
      
      public function update() : void
      {
         throw new Error("抽象方法");
      }
      
      public function update_upAndDown() : void
      {
         throw new Error("抽象方法");
      }
      
      public function hide() : void
      {
         throw new Error("抽象方法");
      }
      
      public function display() : void
      {
         throw new Error("抽象方法");
      }
      
      public function reset() : void
      {
         throw new Error("抽象方法");
      }
      
      public function update_success_copy() : void
      {
         throw new Error("抽象方法");
      }
      
      public function changeEquipBag(_equips:Array = null) : void
      {
         throw new Error("抽象方法");
      }
      
      public function changeEquipSelf(_equips:Array = null) : void
      {
         throw new Error("抽象方法");
      }
      
      public function getClickGrid(grid:View_Grid) : void
      {
         throw new Error("抽象方法");
      }
      
      public function setClickType(_type:int) : void
      {
         throw new Error("抽象方法");
      }
      
      public function getClickVo(_vo:Vo_valuable) : void
      {
         throw new Error("抽象方法");
      }
      
      public function re_set() : void
      {
         canvas_txt.reset();
         canvas_up.reset();
         canvas_down.reset();
      }
      
      public function roleEmptyHandle(gridId:int) : void
      {
         throw new Error("抽象方法");
      }
      
      public function bagEmpthHandle(arr_gridId:Array) : void
      {
         throw new Error("抽象方法");
      }
   }
}

