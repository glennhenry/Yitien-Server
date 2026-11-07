package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.IconButton;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_HuaShanLiJiePanel extends Panel
   {
      
      private var tf_page:MyTextField;
      
      private var _curPage:int = 0;
      
      private var _maxPage:int = 0;
      
      private var _arr:Array = [];
      
      private var _count:int;
      
      private var pool:Array = [];
      
      public function View_HuaShanLiJiePanel()
      {
         super();
         bindParent = GameScene.modalLayer;
         this.initUI2();
      }
      
      private function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":662,
            "height":390
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":614,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":628,
            "y":6,
            "textColor":16184781,
            "callBack":this.closeBtnClickHD
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":267,
            "y":361,
            "textColor":16184781,
            "callBack":this.btnLeftClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageRight",this,{
            "x":374,
            "y":361,
            "textColor":16184781,
            "callBack":this.btnRigthClickHd
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":291,
            "y":361,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_LiJie",this,{
            "x":251,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         this.tf_page = ComponentUtil.getTextField("0/0",this,{
            "x":330,
            "y":362,
            "color":14662240,
            "autoSize":TextFieldAutoSize.CENTER
         });
      }
      
      private function btnLeftClickHd(e:MouseEvent) : void
      {
         this.showPage(this._curPage - 1);
      }
      
      private function btnRigthClickHd(e:MouseEvent) : void
      {
         this.showPage(this._curPage + 1);
      }
      
      public function showPage(index:int) : void
      {
         var pro:Object = null;
         var btn:IconButton = null;
         var bm:Bitmap = null;
         if(index < 0 || index > this._maxPage)
         {
            return;
         }
         this.clear();
         var len:int = this._count - index * 30;
         var s1Jie:int = (this._maxPage - index) * 30 + this._count % 30;
         if(len > 30)
         {
            len = 30;
         }
         var i:int = 0;
         while(i < len)
         {
            pro = {
               "tabIndex":s1Jie - i,
               "label":LangConfig.getWord("29340",2,s1Jie - i),
               "y":int(i / 5) * 51 + 49,
               "x":i % 5 * 121 + 34,
               "callBack":this.btnClickHd
            };
            if(Boolean(this.pool.length))
            {
               btn = this.pool.pop();
            }
            else
            {
               btn = new IconButton("","Button_HeWan",Global.Img_Cdm);
               bm = ComponentUtil.getBitmap("Icon_LiJie",null,{
                  "x":6,
                  "y":6
               },Global.kuafuzhan_Imgsdm);
               btn.icon = bm;
               btn.setLabelOffset(30,0);
            }
            ComponentUtil.setPropertie(btn,pro);
            addChild(btn);
            this._arr.push(btn);
            i += 1;
         }
         this._curPage = index;
         this.tf_page.text = (this._curPage + 1).toString() + "/" + (this._maxPage + 1).toString();
      }
      
      public function update(count:int) : void
      {
         this._maxPage = int(count / 30);
         this._count = count;
         this.showPage(0);
      }
      
      private function clear() : void
      {
         var btn:Button = null;
         for each(btn in this._arr)
         {
            this.pool.push(btn);
            removeChild(btn);
         }
         this._arr.length = 0;
      }
      
      private function btnClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.jie != event.target.tabIndex)
         {
            HuaShanCGMessage.CG_XUANBAMATCHINFO(event.target.tabIndex,1);
         }
         ModalUIManager.UNPOP();
      }
      
      private function closeBtnClickHD(event:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
      }
   }
}

