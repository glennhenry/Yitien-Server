package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class XiaYiShop extends Panel123
   {
      
      private static var _instance:XiaYiShop;
      
      private var back:ScaleBitmap;
      
      private var integral:MyTextField;
      
      public function XiaYiShop()
      {
         super();
         regResource("lang/ch/LeiTai_Imgs.swf","LeiTai_Imgsdm");
      }
      
      public static function get instance() : XiaYiShop
      {
         if(!_instance)
         {
            _instance = new XiaYiShop();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":781,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":40,
            "width":731,
            "height":400
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":747,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var j:int = 0;
         var _id:int = 0;
         var vo:Vo_item = null;
         var voE:Vo_equip = null;
         var xiaYi:XiaYiItem = null;
         var title:int = 0;
         this.integral = ComponentUtil.getTextField("侠义值：0",this,{
            "x":38,
            "y":415,
            "color":16043313,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_XiaYiStore",this,{
            "x":310,
            "y":5
         },Global.LeiTai_Imgsdm);
         i = 0;
         while(i < 3)
         {
            j = 0;
            while(j < 3)
            {
               _id = int(Data_lib.xysc[10001 + i * 3 + j][1]);
               xiaYi = new XiaYiItem();
               if(_id != 0)
               {
                  if(_id > 50000)
                  {
                     voE = new Vo_equip();
                     voE.id = Data_lib.xysc[10001 + i * 3 + j][1];
                     voE.Init_lib();
                     XiaYiItem.grid.vo = voE;
                  }
                  else
                  {
                     vo = new Vo_item();
                     vo.id = Data_lib.xysc[10001 + i * 3 + j][1];
                     vo.Init_lib();
                     XiaYiItem.grid.vo = vo;
                  }
                  xiaYi.x = 30 + j * 242;
                  xiaYi.y = 45 + i * 123;
                  xiaYi.id = _id;
                  xiaYi.integral.text = Data_lib.xysc[10001 + i * 3 + j][2];
                  xiaYi.props.text = Data_lib.xysc[10001 + i * 3 + j][7];
                  title = int(Data_lib.xysc[10001 + i * 3 + j][5]);
                  if(xiaYi.id == 0)
                  {
                     xiaYi.exchangeBtn.enabled = false;
                     xiaYi.upBtn.enabled = false;
                     xiaYi.downBtn.enabled = false;
                     xiaYi.num.text = "0";
                  }
                  switch(title)
                  {
                     case 0:
                        xiaYi.needTitle.text = "";
                  }
                  addChild(xiaYi);
               }
               j++;
            }
            i++;
         }
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      public function updata() : void
      {
         this.integral.text = "侠义值：" + KuaFuJJCVO.wuxiazhi;
      }
      
      public function show() : void
      {
         this.visible = true;
         DRKFjoinPanel.instance.visible = false;
      }
      
      private function onAskSceneOk() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,arguments.callee);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,arguments.callee);
         this.visible = false;
         this.hide();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.updata();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
      }
   }
}

