package com.yiTian.view.modules.KongJianDengLu
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KongJianCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.events.MouseEvent;
   
   public class KongJianBtn
   {
      
      private var yellowBtn:MainUIBtn;
      
      public function KongJianBtn()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var url:String = null;
         if(!this.yellowBtn)
         {
            url = Global.pf == Enum_SPStr.QQ3366 ? "resource/image/Diamond/Icon_SSLL.png" : "resource/image/kongjiandenglu/Icon_DLLB.png";
            this.yellowBtn = new MainUIBtn(url);
         }
      }
      
      public function show() : void
      {
         if(KongJianVO.see == 1)
         {
            if(New_mainBtnContainer.isUsingNewBtn)
            {
               UIManager.newMainBtnContainer.addBtn(this.yellowBtn);
            }
            else
            {
               UIManager.mainUiBtnContainer.addBTN(this.yellowBtn);
            }
            if(KongJianVO._SafeStr_1 != 2)
            {
               UIManager.kongjian.visible = false;
            }
            this.yellowBtn.addEventListener(MouseEvent.CLICK,this.yellowBtnClick);
         }
         else
         {
            if(New_mainBtnContainer.isUsingNewBtn)
            {
               UIManager.newMainBtnContainer.removeBtn(this.yellowBtn);
            }
            else
            {
               UIManager.mainUiBtnContainer.removeBTN(this.yellowBtn);
            }
            this.yellowBtn.removeEventListener(MouseEvent.CLICK,this.yellowBtnClick);
         }
      }
      
      private function yellowBtnClick(e:MouseEvent) : void
      {
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            UIManager.kongjian.visible = true;
            return;
         }
         KongJianCGMessage.CG_OPEN_KONGJIANDENGLU();
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "get"
 */
