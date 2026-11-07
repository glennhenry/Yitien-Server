package com.yiTian.view.modules.paihang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;
   import flashx.textLayout.formats.TextAlign;
   
   public class RoleItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private static var effColor:Array = [new DropShadowFilter(2,250,16777011,0.7)];
      
      private var flowerBtn:Button;
      
      private var indexTf:MyTextField;
      
      private var flowerNum:MyTextField;
      
      private var tt:Child_tianTiUnit;
      
      private var _id:Number;
      
      private var _name:String;
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var nameTf:MyTextField;
      
      private var flwB:Bitmap;
      
      public var isShowEff:Boolean = false;
      
      public function RoleItem()
      {
         super();
         this.init();
      }
      
      public static function get instance() : RoleItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new RoleItem();
      }
      
      private function init() : void
      {
         var pro:Object;
         var arr:Array;
         var i:int;
         this.tt = new Child_tianTiUnit();
         addChild(this.tt);
         this.tt.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            flowerBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
         this.tt.addEventListener(MouseEvent.ROLL_OVER,this.rollOver_tt);
         this.tt.addEventListener(MouseEvent.ROLL_OUT,this.rollOut_tt);
         ComponentUtil.getBitmap("Back_Role",this,{
            "x":6,
            "y":0
         },Global.KFSH_Imgsdm);
         this.flowerBtn = ComponentUtil.getButton("","Button_Flower",this,{
            "x":0,
            "y":83,
            "textColor":16184781
         },Global.KFSH_Imgsdm);
         this.flowerBtn.enabled = false;
         this.flowerBtn.addEventListener(MouseEvent.CLICK,this.flowerBtnClick);
         pro = {
            "x":-20,
            "y":26
         };
         this.flwB = ComponentUtil.getBitmap("Back_DWSH",this,pro,Global.KFSH_Imgsdm);
         this.flwB.visible = false;
         arr = ["第","几","名"];
         i = 0;
         while(i < 3)
         {
            this.tfVec.push(ComponentUtil.getTextField(arr[i],this,{
               "x":88,
               "y":6 + 20 * i,
               "color":14536126,
               "size":12,
               "leading":0,
               "autoSize":TextFieldAutoSize.CENTER
            }));
            i++;
         }
         this.flowerNum = ComponentUtil.getTextField("0",this,{
            "x":28,
            "y":83,
            "color":12560176,
            "size":12,
            "leading":0
         });
         this.tt.filters = effColor;
         ComponentUtil.setPropertie(this.tt,{
            "x":50,
            "y":65
         });
         this.nameTf = ComponentUtil.getTextField("",this,{
            "x":-20,
            "y":65,
            "realWidth":140,
            "align":TextAlign.CENTER
         });
         this.nameTf.mouseEnabled = true;
         this.nameTf.addEventListener(TextEvent.LINK,function():void
         {
            RoleCGMessage.CG_CHECK_OTHERROLE(_id);
         });
      }
      
      private function rollOver_tt(e:MouseEvent) : void
      {
         this.tt.filters = Util.glowBigFFff00;
      }
      
      private function rollOut_tt(e:MouseEvent) : void
      {
         this.tt.filters = effColor;
      }
      
      private function flowerBtnClick(e:MouseEvent) : void
      {
         UIManager.bestowFlower.show(this._id,this._name);
         UIManager.bestowFlower.visible = true;
      }
      
      public function updata(vo:FlowerVO, _type:int) : void
      {
         if(!vo)
         {
            this.tfVec[1].htmlText = _type.toString();
            this.isShowEff = false;
            return;
         }
         this.isShowEff = true;
         this._id = vo.Roleid;
         if(KuaFuMeiLiPanel.instance.week == 1)
         {
            this.flowerBtn.enabled = true;
            this.tt.mouseEnabled = true;
            this.tt.buttonMode = true;
         }
         else
         {
            this.flowerBtn.enabled = false;
            this.tt.mouseEnabled = false;
            this.tt.buttonMode = false;
         }
         this._name = vo.Rolename;
         this.nameTf.htmlText = HtmlUtil.font(HtmlUtil.link("<u>" + this._name + "</u>","ss"),Model_jingJiChang.get_color[Enum_job.getBaseJob(vo.job) - 1]);
         this.tfVec[1].htmlText = vo.index.toString();
         this.flowerNum.text = vo.num.toString();
         this.tt.type = Child_tianTiUnit.PLAYER;
         var _temp_1:* = this.tt;
         this.tt.scaleY = 0.8;
         _temp_1.scaleX = 0.8;
         this.tt.way = 4;
         this.tt.setFrameInterval(300);
         this.tt.job = vo.job;
         this.tt.sex = vo.sex;
         this.tt.name = vo.Rolename;
         this.tt.modelId = vo.model;
         this.tt.updateLayer();
         this.tt.visible = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function showCliSendFlwEff() : void
      {
         if(!this.isShowEff || KuaFuMeiLiPanel.instance.week == 2)
         {
            this.flwB.visible = false;
            return;
         }
         this.flwB.visible = true;
         Tween.to(this.flwB,300,{"alpha":[0,1]});
      }
      
      public function hideCliSwndFlwEff() : void
      {
         if(!this.isShowEff || KuaFuMeiLiPanel.instance.week == 2)
         {
            this.flwB.visible = false;
            return;
         }
         Tween.to(this.flwB,300,{"alpha":[1,0]},function():void
         {
            flwB.visible = false;
         });
      }
      
      public function onFrame(internel:int) : void
      {
         this.tt.onFrame(internel);
      }
      
      public function show(_parent:DisplayObjectContainer) : void
      {
         if(Boolean(_parent) && !_parent.contains(this))
         {
            _parent.addChild(this);
         }
      }
      
      public function clear() : void
      {
         if(Boolean(this.indexTf))
         {
            this.indexTf.text = "";
         }
         if(Boolean(this.nameTf))
         {
            this.nameTf.text = "";
         }
         if(Boolean(this.flowerNum))
         {
            this.flowerNum.text = "0";
         }
         if(Boolean(this.tt))
         {
            this.tt.visible = false;
         }
         if(Boolean(this.flowerBtn))
         {
            this.flowerBtn.enabled = false;
         }
         if(Boolean(this.flwB))
         {
            this.flwB.visible = false;
         }
         this.isShowEff = false;
      }
      
      public function dispose() : void
      {
         if(Boolean(this.indexTf))
         {
            this.indexTf.text = "";
         }
         if(Boolean(this.nameTf))
         {
            this.nameTf.text = "";
         }
         if(Boolean(this.flwB))
         {
            this.flwB.visible = false;
         }
         this.isShowEff = false;
         this._id = 0;
         this._name = "";
         if(Boolean(this.flowerNum))
         {
            this.flowerNum.text = "0";
         }
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         if(Boolean(this.tt))
         {
            this.tt.visible = false;
         }
         if(Boolean(this.flowerBtn))
         {
            this.flowerBtn.enabled = false;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         pool.push(this);
      }
   }
}

