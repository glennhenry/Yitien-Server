package com.yiTian.net.handler
{
   import com.yiTian.data.config.Enum_xiaoxiaole;
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XxlCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.xiaoxiaole.Effect_xxl;
   import com.yiTian.view.modules.xiaoxiaole.View_xiaoxiaole;
   import com.yiTian.view.modules.xiaoxiaole.XXLNode;
   import com.yiTian.view.modules.xiaoxiaole.XXLUtil;
   import mx.utils.StringUtil;
   
   public class XxlHandler
   {
      
      private static var tip:BitmapBtn;
      
      private static const bitmapDir:String = "resource/image/xiaoxiaole/Icon_Po.png";
      
      public function XxlHandler()
      {
         super();
      }
      
      public static function GC_XXL_OPENWIN(b:int, s:String, step:int, jp:int, addJP:int) : void
      {
         var temp:Array;
         if(addJP > 0)
         {
            UIManager.centerBroadcast.addMsg("获得" + addJP + "精魄!");
         }
         Model_xiaoxiaole.getInstance().canOpen = b == Enum_xiaoxiaole.SHOW;
         temp = s.split("_");
         Model_xiaoxiaole.getInstance().toolCounts = temp;
         Model_xiaoxiaole.getInstance().remaindStep = step;
         Model_xiaoxiaole.getInstance().jp = jp;
         if(View_xiaoxiaole.getInstance().visible)
         {
            View_xiaoxiaole.getInstance().update();
            return;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_xiaoxiaole.getInstance(),function():void
         {
            if(!View_xiaoxiaole.getInstance().visible)
            {
               View_xiaoxiaole.getInstance().visible = true;
            }
         });
      }
      
      public static function GC_XXL_CHANGEPOS(b:int, u:String, s:String) : void
      {
         Model_xiaoxiaole.isSelected = false;
         if(b != 1)
         {
            UIManager.centerBroadcast.addMsg("移动失败！");
            return;
         }
         s = s.slice(0,s.length - 1);
         Model_xiaoxiaole.getInstance().gravity = u;
         Model_xiaoxiaole.getInstance().newBlockMap = XXLUtil.getNewBlock(s);
         Effect_xxl.getInstance().moveTwoBoy(function():void
         {
            Model_xiaoxiaole.getInstance().changeMap();
            Effect_xxl.getInstance().playEff();
         });
      }
      
      public static function GC_XXL_GREATEMAP(arr:Array) : void
      {
         Model_xiaoxiaole.getInstance().mapData = arr;
         Model_xiaoxiaole.getInstance().testMap("新产生地图");
         if(View_xiaoxiaole.getInstance().visible)
         {
            View_xiaoxiaole.getInstance().initUI();
         }
      }
      
      public static function GC_XXL_DATA(b:int, s:int) : void
      {
         Model_xiaoxiaole.getInstance().remaindStep = b;
         Model_xiaoxiaole.getInstance().jp = s;
         if(View_xiaoxiaole.getInstance().visible == true)
         {
            View_xiaoxiaole.getInstance().update();
         }
      }
      
      public static function GC_XXL_CLOSE() : void
      {
         if(View_xiaoxiaole.getInstance().visible)
         {
            View_xiaoxiaole.getInstance().visible = false;
         }
      }
      
      public static function GC_XXL_TIP(jp:int, ym:int) : void
      {
         var str:String = StringUtil.substitute("扣除{0}精魄兑换翅膀羽毛*{1},邮件已发送",jp,ym);
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_XXL_KILL_GIRD(flag:int, u:String, s:String) : void
      {
         Model_xiaoxiaole.getInstance().gravity = u;
         s = s.slice(0,s.length - 1);
         Model_xiaoxiaole.getInstance().newBlockMap = XXLUtil.getNewBlock(s);
         Effect_xxl.getInstance().playEff();
      }
      
      public static function GC_XXL_USE_TOOL_CLEAR(color:int, down:String, add:String) : void
      {
         Model_xiaoxiaole.getInstance().gravity = down;
         var arr:Array = Model_xiaoxiaole.getInstance().tool_clear(color);
         add = add.slice(0,add.length - 1);
         Model_xiaoxiaole.getInstance().newBlockMap = XXLUtil.getNewBlock(add);
         Effect_xxl.getInstance().playEff(arr);
      }
      
      public static function GC_XXL_USE_TOOL_PP(p:String, down:String, add:String) : void
      {
         var arr:Array = null;
         var call:Function = null;
         call = function():void
         {
            Effect_xxl.getInstance().playEff(arr);
         };
         Model_xiaoxiaole.getInstance().gravity = down;
         add = add.slice(0,add.length - 1);
         Model_xiaoxiaole.getInstance().newBlockMap = XXLUtil.getNewBlock(add);
         arr = Model_xiaoxiaole.getInstance().getDelListByPP(p);
         View_xiaoxiaole.getInstance().PPP(p,call);
      }
      
      public static function GC_XXL_USE_TOOL_BW(color:int, newcolor:int) : void
      {
         var temp:Array = null;
         var newNode:XXLNode = null;
         var node:XXLNode = null;
         var arr:Array = Model_xiaoxiaole.getInstance().getColorChangeList(color,newcolor);
         if(!arr.length)
         {
            return;
         }
         while(Boolean(arr.length))
         {
            temp = arr.shift();
            newNode = new XXLNode(temp[0],temp[1],newcolor);
            node = View_xiaoxiaole.getInstance().getGridByNode(newNode);
            node.gird.node.value = newNode.value;
            node.gird.playEffect("35287",node.gird.setdate,10,800);
            if(!arr.length)
            {
               View_xiaoxiaole.getInstance().checkMap();
            }
         }
      }
      
      public static function GC_XXL_SHOW_TIP() : void
      {
         if(!tip)
         {
            tip = new BitmapBtn();
            tip.init();
            tip.setBgDir(bitmapDir);
            tip.clickCallBack = function():void
            {
               XxlCGMessage.CG_XXL_OPENWIN();
               removeTip();
            };
         }
         UIManager.tipBtnContainer.addItem(tip);
      }
      
      public static function removeTip() : void
      {
         if(Boolean(tip) && UIManager.tipBtnContainer.contains(tip))
         {
            UIManager.tipBtnContainer.removeItem(tip);
         }
      }
   }
}

