package com.yiTian.view.modules.hapStone
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HapStoneCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.ZaHuoDian.shops.Model_shp;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_hapStone extends Panel123
   {
      
      private static var temStr:String;
      
      private static var _typeIndex:int;
      
      public static const MSG_DATA_BACK:String = "msg_data_back";
      
      public static const MSG_SINGLE_F:String = "msg_single_f";
      
      public static const MSG_SINGLE_S:String = "msg_single_s";
      
      private static const len:int = 6;
      
      private static var isPageChanged:Boolean = false;
      
      private static var isFirst:Boolean = true;
      
      private static var posArr:Array = [];
      
      private var pageTf:MyTextField;
      
      private var cur_page:int = 1;
      
      private var max_page:int = 1;
      
      public var awartItem_vec:Vector.<Child_stoneAward> = new Vector.<Child_stoneAward>(3);
      
      private var nowCortTf:MyTextField;
      
      private var conLeft:Sprite;
      
      private var conRight:Sprite;
      
      public function View_hapStone()
      {
         super();
         regResource("lang/ch/HLZS.swf","HLZSdm");
      }
      
      public static function get instance() : View_hapStone
      {
         return Singleton.getInstance(View_hapStone);
      }
      
      public static function get TipStr() : String
      {
         return temStr || "欢乐钻\n每充值1元宝获得1钻石\n每消费1元宝获得1钻石";
      }
      
      override protected function initUI2() : void
      {
         var sss:Sprite;
         var _dic:DictionaryTabel;
         var i:int;
         var dArr:Array = null;
         var ss:String = null;
         var id:int = 0;
         var nums:int = 0;
         var isLight:int = 0;
         var voS:Vo_hapStone = null;
         var item:Child_stoneAward = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":95,
            "y":0,
            "width":918,
            "height":542
         },Global.Img_Cdm);
         move = new Rectangle(0,0,918,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":120,
            "y":40,
            "width":868,
            "height":492
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":978,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         super.initDynamicView();
         ComponentUtil.getBitmap("Title_HLZS",this,{
            "x":474,
            "y":5
         },Global.HLZSdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":261,
            "y":52,
            "width":565,
            "height":468
         },Global.HLZSdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":830,
            "y":52,
            "width":146,
            "height":468
         },Global.HLZSdm);
         ComponentUtil.getBitmap("Back_RenWu",this,{
            "x":0,
            "y":14
         },Global.HLZSdm);
         ComponentUtil.getBitmap("Light_CZHK",this,{
            "x":830,
            "y":52
         },Global.HLZSdm);
         ComponentUtil.getBitmap("Light_XLDH",this,{
            "x":261,
            "y":52
         },Global.HLZSdm);
         ComponentUtil.getBitmap("Text_CZHK",this,{
            "x":874,
            "y":56
         },Global.HLZSdm);
         ComponentUtil.getBitmap("Text_XLDH",this,{
            "x":512,
            "y":56
         },Global.HLZSdm);
         ComponentUtil.getTextField(" \n每充值或消费1元宝会获得1欢乐钻",this,{
            "x":277,
            "y":476,
            "color":16711680,
            "size":12,
            "leading":3
         });
         ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":489,
            "y":442,
            "textColor":16771436,
            "tabIndex":0,
            "callBack":this.page_change
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageRight",this,{
            "x":576,
            "y":442,
            "textColor":16771436,
            "tabIndex":1,
            "callBack":this.page_change
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":514,
            "y":441,
            "width":57,
            "height":21
         },Global.Img_Cdm);
         this.pageTf = ComponentUtil.getTextField("1/3",this,{
            "x":531,
            "y":442,
            "color":16777215,
            "size":12,
            "leading":0
         });
         sss = new Sprite();
         addChild(sss);
         ComponentUtil.getBitmap("Icon_Zuan",sss,{
            "x":589,
            "y":487
         },Global.HLZSdm);
         TipManager.bind(sss,View_hapStone.TipStr);
         ComponentUtil.getTextField(":",this,{
            "x":610,
            "y":485,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":620,
            "y":486,
            "width":78,
            "height":18
         },Global.Img_Cdm);
         this.nowCortTf = ComponentUtil.getTextField("0",this,{
            "x":622,
            "y":485,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":835,
            "y":224,
            "width":135,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":835,
            "y":371,
            "width":135,
            "height":2
         },Global.Img_Cdm);
         this.conLeft = new Sprite();
         this.conRight = new Sprite();
         addChild(this.conLeft);
         addChild(this.conRight);
         ComponentUtil.setPropertie(this.conLeft,{
            "x":268,
            "y":86
         });
         ComponentUtil.setPropertie(this.conRight,{
            "x":849,
            "y":89
         });
         HapManager.addMaskUnit({
            "x":268,
            "y":86,
            "width":552,
            "height":345
         },this.conLeft);
         HapManager.addMaskUnit({
            "x":849,
            "y":86,
            "width":140,
            "height":443
         },this.conRight);
         _dic = Data_lib.hapStoneAward;
         i = 0;
         while(i < this.awartItem_vec.length)
         {
            dArr = _dic[i + 1];
            ss = dArr[0];
            id = int(ss.split("_")[1]);
            nums = int(ss.split("_")[2]);
            isLight = int(dArr[2]);
            voS = new Vo_hapStone();
            voS.jifen = dArr[1];
            voS.index = i + 1;
            voS.itemSellCount = nums;
            voS.isLight = isLight;
            voS.init(id);
            item = new Child_stoneAward();
            item.init(voS);
            this.conRight.addChild(item);
            this.awartItem_vec[i] = item;
            ComponentUtil.setPropertie(item,{
               "x":-130,
               "y":i * 147
            });
            i++;
         }
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":722,
            "y":480,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
            }
         },Global.Img_Cdm);
      }
      
      private function page_change(e:MouseEvent) : void
      {
         _typeIndex = e.target.tabIndex;
         switch(_typeIndex)
         {
            case 0:
               if(this.cur_page <= 1)
               {
                  return;
               }
               --this.cur_page;
               break;
            case 1:
               if(this.cur_page >= this.max_page)
               {
                  return;
               }
               ++this.cur_page;
         }
         this.cur_page = this.cur_page < 1 ? 1 : this.cur_page;
         this.cur_page = this.cur_page > this.max_page ? this.max_page : this.cur_page;
         isPageChanged = true;
         this.update();
      }
      
      private function update() : void
      {
         var child_hapSItem:Child_hapStone = null;
         var voHS:Vo_hapStone = null;
         this.pageTf.text = this.cur_page + "/" + this.max_page;
         var _dataA:Array = Model_shp.getData(Model_hapStone.data_of_voStone,this.cur_page,len);
         this.part_reset();
         posArr = [];
         var i:int = 0;
         while(i < _dataA.length)
         {
            child_hapSItem = Child_hapStone.instance;
            voHS = _dataA[i];
            if(!contains(child_hapSItem))
            {
               this.conLeft.addChild(child_hapSItem);
               if(isPageChanged)
               {
                  if(_typeIndex == 0)
                  {
                     ComponentUtil.setPropertie(child_hapSItem,{
                        "x":-200,
                        "y":int(i / 3) * 175
                     });
                  }
                  else
                  {
                     ComponentUtil.setPropertie(child_hapSItem,{
                        "x":600,
                        "y":int(i / 3) * 175
                     });
                  }
                  posArr.push({
                     "x":int(i % 3) * 185,
                     "y":int(i / 3) * 175
                  });
               }
               else
               {
                  ComponentUtil.setPropertie(child_hapSItem,{
                     "x":int(i % 3) * 185,
                     "y":int(i / 3) * 175
                  });
               }
            }
            child_hapSItem.init_data(voHS);
            Child_hapStone.list.push(child_hapSItem);
            i++;
         }
         this.nowCortTf.htmlText = Model_hapStone.nowScore.toString();
         if(isPageChanged)
         {
            this.tween2Static(0);
         }
         isPageChanged = false;
      }
      
      private function tween2Static(index:int) : void
      {
         var item:Child_hapStone;
         var obj:Object;
         var nn:int = 0;
         if(index >= Child_hapStone.list.length || !visible)
         {
            return;
         }
         item = Child_hapStone.list[index];
         obj = posArr[index];
         nn = int(setTimeout(function(it:Child_hapStone, pp:Object):void
         {
            clearTimeout(nn);
            Tween.to(it,400,{"x":[it.x,pp.x]},null,null,Tween.SIN010);
            tween2Static(++index);
         },50,item,obj));
      }
      
      private function update_singleF(obj:Object) : void
      {
         var nowChap:Child_hapStone = Child_hapStone.list[int((obj.index - 1) % len)];
         nowChap.leftNum = obj.leftNum;
         this.nowCortTf.htmlText = Model_hapStone.nowScore.toString();
      }
      
      private function update_singleS() : void
      {
         var key:String = null;
         for(key in this.awartItem_vec)
         {
            this.awartItem_vec[key].update();
         }
      }
      
      private function part_reset() : void
      {
         var i:int = Child_hapStone.list.length - 1;
         while(i >= 0)
         {
            Child_hapStone.list[i].dispose();
            i--;
         }
      }
      
      private function initDic() : void
      {
         var key:String = null;
         var vo_hStone:Vo_hapStone = null;
         var id:int = 0;
         var _dic:DictionaryTabel = Data_lib.hapStone;
         for(key in _dic)
         {
            vo_hStone = new Vo_hapStone();
            id = int(_dic[key][0]);
            if(id != 0)
            {
               vo_hStone.itemSellCount = _dic[key][1];
               vo_hStone.index = int(key);
               vo_hStone.jifen = _dic[key][2];
               vo_hStone.isLight = _dic[key][3];
               vo_hStone.init(id);
               Model_hapStone.data_of_voStone.push(vo_hStone);
            }
         }
         Model_hapStone.data_of_voStone.sortOn("index",Array.NUMERIC);
         this.max_page = Model_hapStone.data_of_voStone.length / len + int(Model_hapStone.data_of_voStone.length % len != 0);
         this.update();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var mm:int = 0;
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(MSG_DATA_BACK,this.update);
            Global.control.registerCallBack(MSG_SINGLE_F,this.update_singleF);
            Global.control.registerCallBack(MSG_SINGLE_S,this.update_singleS);
            if(isFirst)
            {
               isFirst = false;
               this.initDic();
            }
            HapStoneCGMessage.CG_OPEN_HAP_PAN();
            mm = int(setTimeout(function():void
            {
               clearTimeout(mm);
               tweenEff(0);
            },100));
         }
         else
         {
            Global.control.registerCallBack(MSG_DATA_BACK,this.update);
            Global.control.registerCallBack(MSG_SINGLE_F,this.update_singleF);
            Global.control.registerCallBack(MSG_SINGLE_S,this.update_singleS);
            this.tweenEffBack(0);
         }
      }
      
      private function tweenEff(index:int) : void
      {
         var childHa:Child_stoneAward;
         var bb:int = 0;
         if(index >= this.awartItem_vec.length)
         {
            return;
         }
         childHa = this.awartItem_vec[index];
         bb = int(setTimeout(function(childHa:Child_stoneAward):void
         {
            clearTimeout(bb);
            Tween.to(childHa,600,{"x":[-130,0]},null,null,Tween.SIN);
            tweenEff(++index);
         },100,childHa));
      }
      
      private function tweenEffBack(index:int) : void
      {
         var childHa:Child_stoneAward;
         var bb:int = 0;
         if(index >= this.awartItem_vec.length)
         {
            return;
         }
         childHa = this.awartItem_vec[index];
         bb = int(setTimeout(function(childHa:Child_stoneAward):void
         {
            clearTimeout(bb);
            Tween.to(childHa,600,{"x":[0,-130]},null,null,Tween.SIN);
            tweenEffBack(++index);
         },100,childHa));
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 918) / 2;
         y = (Global.stage.stageHeight - 540) / 2;
      }
   }
}

