package com.yiTian.view.modules.moneyTree
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.model.Model_MoneyTree;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MoneyTreeCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class Item_MoneyTree extends Sprite
   {
      
      private static var labelArr:Array = [0,20,40,60,80,100];
      
      private static var costYB:Array = [0,20,200,1000];
      
      private static var costPlantYB:Array = [0,88,888,8888];
      
      private var btn_arr:Vector.<Button> = new Vector.<Button>();
      
      private var _index:int;
      
      private var able:Boolean;
      
      private var arr:Array = new Array();
      
      private var vecGrids:Vector.<View_Grid>;
      
      private var showCK:Boolean;
      
      private var maxW:int;
      
      private var title_txt:MyTextField;
      
      private var bm:Bitmap;
      
      private var growValue:MyTextField;
      
      private var zz_btn:Button;
      
      private var gg_btn:Button;
      
      private var lq_btn:Button;
      
      private var tempIndex:int;
      
      private var tree:Bitmap;
      
      private var img_flag:Bitmap;
      
      private var img_zzfh:Bitmap;
      
      public function Item_MoneyTree()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_ShuLan",this,{
            "x":22,
            "y":119
         },Global.YQSdm);
         this.tree = new Bitmap();
         this.tree.x = 30;
         this.addChild(this.tree);
         this.zz_btn = ComponentUtil.getButton("种植摇钱树","Button_WeiYang",this,{
            "x":34,
            "y":126,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.YQSdm);
         this.img_zzfh = new Bitmap();
         this.img_zzfh.y = 160;
         this.addChild(this.img_zzfh);
         var spr:Sprite = new Sprite();
         ComponentUtil.getBitmap("Back_JDTD",spr,{
            "x":11,
            "y":225
         },Global.YQSdm);
         this.addChild(spr);
         this.bm = ComponentUtil.getBitmap("Back_JDT",this,{
            "x":15,
            "y":228
         },Global.YQSdm);
         this.maxW = this.bm.width;
         var str:String = "";
         str += "<font color=\'#739e5a\'>成长值增加</font>\n";
         str += "    提升玩家等级获得<font color=\'#04ff00\'>（成长值=当前等级/10的值取整数）</font>\n";
         str += "    元宝浇灌可以获得<font color=\'#04ff00\'>20%</font>成长值\n";
         str += "<font color=\'#739e5a\'>成长值奖励</font>\n";
         str += "    成长值达到<font color=\'#04ff00\'>20%、40%、60%、80%、100%</font>\n";
         str += "    时，则可以领取丰富奖励";
         var vo:Vo_DynamicTip = new Vo_DynamicTip();
         vo._w = 450;
         vo.info = str;
         TipManager.bind(spr,vo);
         ComponentUtil.getBitmap("Back_JDTX",this,{
            "x":45,
            "y":228
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_JDTX",this,{
            "x":75,
            "y":228
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_JDTX",this,{
            "x":106,
            "y":228
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_JDTX",this,{
            "x":136,
            "y":228
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_YQJT",this,{
            "x":35,
            "y":238
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_YQJT",this,{
            "x":65,
            "y":238
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_YQJT",this,{
            "x":96,
            "y":238
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_YQJT",this,{
            "x":126,
            "y":238
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_YQJT",this,{
            "x":157,
            "y":238
         },Global.YQSdm);
         ComponentUtil.getBitmap("Text_CZZJL",this,{
            "x":64,
            "y":289
         },Global.YQSdm);
         ComponentUtil.getBitmap("Text_CZZ",this,{
            "x":15,
            "y":199
         },Global.YQSdm);
         var c5:Button = ComponentUtil.getButton("","Button_JDSZ",this,{
            "x":144,
            "y":254,
            "textColor":16771436,
            "name":"cc5",
            "callBack":this.onClickHandler
         },Global.YQSdm);
         var c4:Button = ComponentUtil.getButton("","Button_JDSZ",this,{
            "x":114,
            "y":254,
            "textColor":16771436,
            "name":"cc4",
            "callBack":this.onClickHandler
         },Global.YQSdm);
         var c3:Button = ComponentUtil.getButton("","Button_JDSZ",this,{
            "x":84,
            "y":254,
            "textColor":16771436,
            "name":"cc3",
            "callBack":this.onClickHandler
         },Global.YQSdm);
         var c2:Button = ComponentUtil.getButton("","Button_JDSZ",this,{
            "x":53,
            "y":254,
            "textColor":16771436,
            "name":"cc2",
            "callBack":this.onClickHandler
         },Global.YQSdm);
         var c1:Button = ComponentUtil.getButton("","Button_JDSZ",this,{
            "x":23,
            "y":254,
            "textColor":16771436,
            "name":"cc1",
            "callBack":this.onClickHandler
         },Global.YQSdm);
         this.gg_btn = ComponentUtil.getButton("元宝灌溉","BT_DH",this,{
            "x":105,
            "y":197,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.YQSdm);
         ComponentUtil.getTextField("20%",this,{
            "x":25,
            "y":255,
            "color":16777215,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField("40%",this,{
            "x":55,
            "y":255,
            "color":16777215,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField("60%",this,{
            "x":86,
            "y":255,
            "color":16777215,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField("80%",this,{
            "x":116,
            "y":255,
            "color":16777215,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField("100%",this,{
            "x":144,
            "y":255,
            "color":16777215,
            "size":11,
            "leading":0
         });
         this.btn_arr.push(c1,c2,c3,c4,c5);
         this.title_txt = ComponentUtil.getTextField("20%",this,{
            "x":45,
            "y":289,
            "color":16184781,
            "size":14,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.lq_btn = ComponentUtil.getButton("领取","Button_Orange",this,{
            "x":55,
            "y":368,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.Img_Cdm);
         this.growValue = ComponentUtil.getTextField("",this,{
            "x":75,
            "y":195,
            "color":16184781,
            "size":16,
            "leading":0,
            "bold":true
         },TextFieldAutoSize.CENTER);
         this.growValue.htmlText = "0<font size=\'12\'>%</font>";
         this.vecGrids = new Vector.<View_Grid>();
         this.bm.width = 0;
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var inde:int = 0;
         var tempIn:int = 0;
         var spr:Button = e.target as Button;
         inde = int(spr.name.charAt(2));
         switch(inde)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               tempIn = inde - 1;
               this.tempIndex = inde;
               this.showAwards(tempIn);
               this.title_txt.htmlText = labelArr[inde] + "%";
               if(Boolean(Model_MoneyTree.status.length))
               {
                  this.lq_btn.mouseEnabled = this.lq_btn.enabled = Model_MoneyTree.status[tempIn] == 1;
               }
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var ck:Function = null;
         var execut:Function = null;
         var tip:String = null;
         ck = function(box:CheckBox):void
         {
            showCK = box.selected;
         };
         execut = function():void
         {
            MoneyTreeCGMessage.CG_MONEYTREE_WATER();
         };
         var btn:Button = e.target as Button;
         var nameArr:Array = ["青铜摇钱树","白银摇钱树","黄金摇钱树"];
         switch(btn.label)
         {
            case "种植摇钱树":
               if(Model_MoneyTree.currentTree == 0)
               {
                  tip = "<font color=\'#ffffff\'>你确定要花费<font color=\'#f9ff00\'>" + costPlantYB[this.index] + "元宝</font>种植<font color=\'#f9ff00\'>" + nameArr[this.index - 1] + "</font>?</font>" + "\n  <font color=\'#fe0000\'>注：每个玩家只能种植一次摇钱树</font>" + "\n  <font color=\'#fe0000\'>    该活动不参与任何消费活动</font>";
                  View_Alert.show(tip,View_Alert.OK_CANCAL,function():void
                  {
                     MoneyTreeCGMessage.CG_MONEYTREE_PLANT(index);
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg("只能种植一颗摇钱树",1);
               break;
            case "领取":
               MoneyTreeCGMessage.CG_MONEYTREE_GETWARD(this.tempIndex);
               break;
            case "元宝灌溉":
               if(Model_MoneyTree.currentTree == 0)
               {
                  UIManager.centerBroadcast.addMsg("请先种植一颗摇钱树",1);
                  return;
               }
               if(this.showCK)
               {
                  execut();
                  return;
               }
               View_Alert.show("是否花费<font color=\'#7fb547\'>" + costYB[this.index] + "元宝</font>灌溉获得<font color=\'#7fb547\'>20%</font>成长值？" + "\n  <font color=\'#fe0000\'>    该活动不参与任何消费活动</font>",View_Alert.OK_CANCAL,execut,null,null,null,320,"","",TextFormatAlign.LEFT,true);
               View_Alert.instance.showCheckBox = ck;
         }
      }
      
      private function showAwards(__index:int) : void
      {
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var award:Array = null;
         var i:int = 0;
         var changelStr:Function = function(str:String):Array
         {
            var temp:Array = null;
            var j:int = 0;
            var temp1:Array = null;
            var reslut:Array = [];
            if(str.indexOf(",") != -1)
            {
               temp = str.split(",");
               j = 0;
               while(j < temp.length)
               {
                  temp1 = (temp[j] as String).split("_");
                  reslut.push([temp1[1],temp1[2]]);
                  j++;
               }
               return reslut;
            }
            temp1 = str.split("_");
            reslut.push([temp1[1],temp1[2]]);
            return reslut;
         };
         award = changelStr(this.arr[__index][2]);
         var len:int = int(award.length);
         this.vecGrids = new Vector.<View_Grid>();
         i = 0;
         while(i < len)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over();
            grid.set_tf_count(true,true,true);
            grid.set_bmp_bg();
            grid.set_tf_count();
            grid.x = 12 + 43 * i;
            grid.y = 327;
            grid.count = i;
            vo = new Vo_item();
            vo.id = award[i][0];
            vo.count = award[i][1];
            vo.Init_lib();
            grid.vo = vo;
            grid.set_bmp_select();
            TipManager.unBind(grid);
            addChild(grid);
            this.vecGrids.push(grid);
            i++;
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(value:int) : void
      {
         var key:int = 0;
         this._index = value;
         var nameArr:Array = ["","Back_QTYQ","Back_BYYQ","Back_HJYQ"];
         this.tree.bitmapData = ComponentUtil.getBitmapData(nameArr[value],Global.YQSdm);
         var nameArr1:Array = ["","Text_ZZFH","Text_ZZFHE","Text_ZZFHS"];
         this.img_zzfh.bitmapData = ComponentUtil.getBitmapData(nameArr1[value],Global.YQSdm);
         TipManager.bind(this.zz_btn,"种植需要花费<font color=\'#04ff00\'>" + costPlantYB[value] + "元宝</font>");
         var na:Array = ["","青铜摇钱树","白银摇钱树","黄金摇钱树"];
         TipManager.bind(this.gg_btn,"灌溉" + na[value] + "需要花费<font color=\'#04ff00\'>" + costYB[value] + "元宝</font>");
         var dicc:DictionaryTabel = Data_lib.moneyTree;
         var i:int = 1;
         while(i < 16)
         {
            key = int((i - 1) / 5) + 1;
            if(key == this._index)
            {
               this.arr.push(dicc[i]);
            }
            i++;
         }
         this.showAwards(0);
      }
      
      public function update() : void
      {
         var canGet:Boolean = false;
         var isFirstIndex:Boolean = false;
         var temps:int = 0;
         var a:Array = null;
         var ii:int = 0;
         if(this.index == Model_MoneyTree.currentTree)
         {
            this.zz_btn.visible = false;
         }
         var iii:int = int(Model_MoneyTree.growPer / 20 + 1) * 20;
         iii = iii > 100 ? 100 : iii;
         var i:int = 0;
         while(i < Model_MoneyTree.status.length)
         {
            a = Model_MoneyTree.status;
            if(Model_MoneyTree.status[i] == 1)
            {
               if(!isFirstIndex)
               {
                  this.tempIndex = i + 1;
                  isFirstIndex = true;
               }
               if(!canGet)
               {
                  iii = (i + 1) * 20;
                  temps = i;
               }
               canGet = true;
               this.btn_arr[i].filters = [];
            }
            else
            {
               this.btn_arr[i].filters = Util.disabled;
            }
            i++;
         }
         this.title_txt.htmlText = iii + "%";
         this.gg_btn.filters = [];
         if(canGet)
         {
            temps = temps == 5 ? 4 : temps;
            this.showAwards(temps);
            this.btn_arr[temps].filters = [];
            this.lq_btn.filters = [];
         }
         else
         {
            this.lq_btn.filters = Util.disabled;
            ii = Model_MoneyTree.growPer / 20;
            ii = ii == 5 ? 4 : ii;
            this.showAwards(ii);
         }
         this.bm.width = this.maxW * Model_MoneyTree.growPer / 100;
         this.growValue.htmlText = Model_MoneyTree.growPer + "<font size=\'12\'>%</font>";
      }
      
      public function bitmapd() : BitmapData
      {
         return this.tree.bitmapData;
      }
      
      public function flyIcon() : void
      {
         var i:int = 0;
         while(i < this.vecGrids.length)
         {
            Tween.gridToBagBezierFuncDef(this.vecGrids[i]);
            i++;
         }
      }
      
      public function eff_yb() : void
      {
         var effect:Effect = EffectManager.addEffect("35040",this,800,11,11);
         Tween.to(effect,800,{
            "x":[30,70],
            "y":[11,228]
         },function(effect:Effect):void
         {
            EffectManager.removeEffect(effect);
         });
      }
      
      public function setStatus(type:int) : void
      {
         switch(type)
         {
            case 0:
               this.zz_btn.mouseEnabled = this.lq_btn.enabled = true;
               this.gg_btn.mouseEnabled = this.lq_btn.enabled = true;
               this.gg_btn.filters = this.zz_btn.filters = [];
               this.lq_btn.mouseEnabled = this.lq_btn.enabled = false;
               break;
            case 1:
               this.zz_btn.mouseEnabled = this.lq_btn.enabled = false;
               this.gg_btn.mouseEnabled = this.lq_btn.enabled = false;
               this.gg_btn.filters = this.zz_btn.filters = Util.disabled;
               this.lq_btn.mouseEnabled = this.lq_btn.enabled = false;
               break;
            case 2:
               this.gg_btn.mouseEnabled = this.lq_btn.enabled = true;
               this.gg_btn.filters = this.zz_btn.filters = [];
         }
      }
   }
}

