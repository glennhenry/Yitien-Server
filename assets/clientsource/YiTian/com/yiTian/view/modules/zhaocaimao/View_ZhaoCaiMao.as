package com.yiTian.view.modules.zhaocaimao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TextInput;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_ZhaoCaiMao;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.ZhaoCaiMaoCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.Panel123;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_ZhaoCaiMao extends Panel123
   {
      
      public static var vo:Vo_DynamicTip;
      
      private static var _instance:View_ZhaoCaiMao;
      
      private var zm_btn:Button;
      
      private var ly_btn:Button;
      
      private var min_btn:Button;
      
      private var max_btn:Button;
      
      private var send_btn:Button;
      
      private var help_btn:Button;
      
      private var input_txt:TextInput;
      
      private var mflag_txt:MyTextField;
      
      private var index_txt:MyTextField;
      
      private var bottomCon:Sprite;
      
      private var contentCon:Sprite;
      
      private var itemVec:Vector.<Child_ZhaoCaiMao>;
      
      private var isInit:Boolean;
      
      public function View_ZhaoCaiMao()
      {
         super();
         regResource("lang/ch/ZCLM.swf","ZCLMdm");
      }
      
      public static function get instance() : View_ZhaoCaiMao
      {
         if(!_instance)
         {
            _instance = new View_ZhaoCaiMao();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var str:String;
         var lib:Array;
         var len:int;
         var arr:Array;
         var tipStr:String;
         var itemColor:Array;
         var item:Child_ZhaoCaiMao = null;
         var bmd:BitmapData = null;
         var i:int = 0;
         var str2:String = null;
         var pid:int = 0;
         var pcount:int = 0;
         var str1:String = null;
         var color:int = 0;
         var key:int = 0;
         var k:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":863,
            "height":628
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":813,
            "height":578
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":828,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_ZCLM",this,{
            "x":351,
            "y":5
         },Global.ZCLMdm);
         ComponentUtil.getBitmap("Back_ZCLM",this,{
            "x":37,
            "y":52
         },Global.ZCLMdm);
         this.mflag_txt = ComponentUtil.getTextField("我的招财猫编号：000号",this,{
            "x":87,
            "y":588,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.bottomCon = new Sprite();
         this.bottomCon.x = 299;
         this.bottomCon.y = 585;
         addChild(this.bottomCon);
         this.ly_btn = ComponentUtil.getButton("","Button_SiYang",this.bottomCon,{
            "x":0,
            "y":0,
            "textColor":16771436,
            "callBack":this.lyHandler
         },Global.ZCLMdm);
         ComponentUtil.getTextField("召唤招财猫",this.bottomCon,{
            "x":9,
            "y":2,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.zm_btn = ComponentUtil.getButton("","Button_SiYang",this.bottomCon,{
            "x":184,
            "y":0,
            "textColor":16771436,
            "callBack":this.zmHandler
         },Global.ZCLMdm);
         ComponentUtil.getTextField("招募饲养",this.bottomCon,{
            "x":200,
            "y":2,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_PTD",[3,3,1,1],this.bottomCon,{
            "x":111,
            "y":3,
            "width":43,
            "height":17
         },Global.ZCLMdm);
         ComponentUtil.getScaleBitmap("Back_PTD",[3,3,1,1],this.bottomCon,{
            "x":348,
            "y":1,
            "width":100,
            "height":22
         },Global.ZCLMdm);
         this.input_txt = ComponentUtil.getTextInput("输入编号","TextInput1",this.bottomCon,{
            "x":350,
            "y":2,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.send_btn = ComponentUtil.getButton("","Button_SouSuo",this.bottomCon,{
            "x":450,
            "y":0,
            "textColor":16771436,
            "callBack":this.onSendHandler
         },Global.ZCLMdm);
         ComponentUtil.getTextField("搜索",this.bottomCon,{
            "x":460,
            "y":2,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.min_btn = ComponentUtil.getButton("","Button_XiangZuo",this.bottomCon,{
            "x":89,
            "y":2,
            "textColor":16771436,
            "callBack":this.onMinHandler
         },Global.ZCLMdm);
         this.max_btn = ComponentUtil.getButton("","Button_XiangYuo",this.bottomCon,{
            "x":156,
            "y":2,
            "textColor":16771436,
            "callBack":this.onMaxHandler
         },Global.ZCLMdm);
         this.index_txt = ComponentUtil.getTextField("00/00",this.bottomCon,{
            "x":114,
            "y":2,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.itemVec = new Vector.<Child_ZhaoCaiMao>();
         move = new Rectangle(0,0,816,36);
         this.help_btn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":800,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         str = "1.活动期间，每人可召唤一只招财猫。\n2.玩家不能喂养自己的灵猫。\n3.每只招财猫每天只能接受<font color=\'#04ff00\'>20次</font>饲养。\n4.每人每天对同一个招财猫只能喂养一次。\n5.达到的喂养目标越高，获得的奖励越丰富。";
         TipManager.bind(this.help_btn,str);
         i = 0;
         while(i < 15)
         {
            item = Pool.getObject(Child_ZhaoCaiMao);
            item.x = 51 + 153 * (i % 5);
            item.y = 71 + 169 * int(i / 5);
            this.addChild(item);
            this.itemVec.push(item);
            i++;
         }
         MassLoader.add("modelRes/magic/35327.swf",function(info:Object):void
         {
            bmd = ComponentUtil.getBitmapData("_0",info.applicationDomain);
            i = 0;
            while(i < 15)
            {
               item = itemVec[i];
               item.bmd = bmd;
               ++i;
            }
         });
         this.input_txt.addEventListener(MouseEvent.CLICK,this.onTextClick);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.isInit = true;
         lib = Data_lib.zhaocaimao.toArray();
         len = int(lib.length);
         arr = [];
         tipStr = "";
         itemColor = ["#000000","#ffffff","#00ffff","#33ccff","#bb00ff","#ff7700"];
         i = 0;
         while(i < len)
         {
            str2 = lib[i][2];
            arr = str2.split(",");
            key = int(lib[i][1]);
            tipStr += "接受喂养<font color=\'#04ff00\'>" + key + "次</font>奖励：";
            if(key < 100)
            {
               tipStr += " ";
            }
            k = 0;
            while(k < arr.length)
            {
               pid = int((arr[k] as String).split("_")[1]);
               pcount = int((arr[k] as String).split("_")[2]);
               color = int(Data_lib.item[pid][Enum_lib_item.COLOR]);
               if(k == arr.length - 1)
               {
                  tipStr += "<font color = \'" + itemColor[color] + "\'>" + Data_lib.item[pid][Enum_lib_item.STR_NAME] + "</font>" + "*" + pcount + "<br/>";
               }
               else
               {
                  tipStr += "<font color = \'" + itemColor[color] + "\'>" + Data_lib.item[pid][Enum_lib_item.STR_NAME] + "</font>" + "*" + pcount + "、";
               }
               k++;
            }
            i++;
         }
         vo = new Vo_DynamicTip();
         vo._w = 405;
         vo.info = tipStr;
      }
      
      protected function onTextClick(event:MouseEvent) : void
      {
         this.input_txt.text = "";
      }
      
      private function onSendHandler(e:MouseEvent) : void
      {
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_SEARCH(this.input_txt.text);
      }
      
      private function onMinHandler(e:MouseEvent) : void
      {
         if(Model_ZhaoCaiMao.instance.currentPage - 1 <= 0)
         {
            return;
         }
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_PAGE(Model_ZhaoCaiMao.instance.currentPage - 1);
      }
      
      private function onMaxHandler(e:MouseEvent) : void
      {
         if(Model_ZhaoCaiMao.instance.currentPage + 1 > Model_ZhaoCaiMao.instance.maxPage)
         {
            return;
         }
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_PAGE(Model_ZhaoCaiMao.instance.currentPage + 1);
      }
      
      private function lyHandler(e:MouseEvent) : void
      {
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_LY();
      }
      
      private function zmHandler(e:MouseEvent) : void
      {
         Model_ZhaoCaiMao.instance.ZM();
      }
      
      public function update() : void
      {
         var item:Child_ZhaoCaiMao = null;
         var i:int = 0;
         var len:int = int(Model_ZhaoCaiMao.instance.data.length);
         this.mflag_txt.text = "我的招财猫编号：" + Model_ZhaoCaiMao.instance.myIndex;
         this.index_txt.text = Model_ZhaoCaiMao.instance.currentPage + "/" + Model_ZhaoCaiMao.instance.maxPage;
         i = 0;
         while(i < 15)
         {
            item = this.itemVec[i];
            if(i < len)
            {
               item.dispose();
               item.visible = true;
               item.update(Model_ZhaoCaiMao.instance.data[i]);
            }
            else
            {
               item.dispose();
            }
            i++;
         }
      }
      
      public function showEff(id:Number) : void
      {
         var item:Child_ZhaoCaiMao = null;
         if(!this.isInit)
         {
            return;
         }
         var i:int = 0;
         while(i < 15)
         {
            item = this.itemVec[i];
            if(item.index == id)
            {
               item.eff();
            }
            i++;
         }
      }
      
      public function show() : void
      {
         Model_ZhaoCaiMao.instance.currentPage = 1;
         ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_OPENWIN();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

