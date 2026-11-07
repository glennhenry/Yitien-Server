package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_XingZuoCountAtb;
   import flash.display.DisplayObject;
   
   public class View_XingZuoAtbCountTip extends View_tip
   {
      
      private var _isinit:Boolean = false;
      
      private var _line:DisplayObject;
      
      private var _tfName:MyTextField;
      
      private var _tfName2:MyTextField;
      
      private var _info:MyTextField;
      
      private var _vo:Vo_XingZuoCountAtb;
      
      private var margin:int = 8;
      
      private var _tfTip:MyTextField;
      
      private var _border1:ScaleBitmap;
      
      private var _border2:ScaleBitmap;
      
      private var __leading:Number = 4;
      
      private var _versionRecord:int = -1;
      
      private var _tfs:Array = [];
      
      public function View_XingZuoAtbCountTip()
      {
         super();
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var ar:Array = null;
         var ofx:int = 0;
         var hgap:int = 0;
         var maxHeight:Number = NaN;
         var maxWidth:Number = NaN;
         var vgap:int = 0;
         var sy:int = 0;
         var i:int = 0;
         var maxWidth2:int = 0;
         var ww:Number = NaN;
         var hh:Number = NaN;
         var dtf:MyTextField = null;
         var j:int = 0;
         var str:String = null;
         var tf:MyTextField = null;
         var count:int = 0;
         var th:Number = NaN;
         var tw:Number = NaN;
         var rightBarTf:MyTextField = null;
         this.tryInit();
         this._vo = obj as Vo_XingZuoCountAtb;
         if(obj == this._vo && this._versionRecord == this._vo._version)
         {
            return;
         }
         this._versionRecord = this._vo._version;
         this._info.htmlText = this._vo.staticAtbStr;
         for each(ar in this._tfs)
         {
            for each(dtf in ar)
            {
               removeChild(dtf);
               dtf.leading = 0;
               dtf.dispose();
            }
         }
         this._tfs.length = 0;
         ofx = 0;
         hgap = 15;
         maxHeight = 0;
         maxWidth = 0;
         vgap = 8;
         sy = this._info.y + this._info.textHeight;
         if(Boolean(this._vo.servStrs.length))
         {
            this._tfName2.visible = true;
            this._tfName2.y = sy + vgap;
            sy = this._tfName2.y + this._tfName2.textHeight + this.margin;
         }
         var maxWidthMap:Object = {};
         i = 0;
         while(i < this._vo.servStrs.length)
         {
            ar = [];
            j = 0;
            while(j < this._vo.servStrs[i].length)
            {
               str = this._vo.servStrs[i][j];
               tf = ComponentUtil.getTextField("",null);
               tf.htmlText = str;
               if(maxWidthMap[j] == null || tf.textWidth > maxWidthMap[j])
               {
                  maxWidthMap[j] = tf.textWidth;
               }
               addChild(tf);
               ar.push(tf);
               j += 1;
            }
            this._tfs.push(ar);
            i += 1;
         }
         i = 0;
         while(i < this._tfs.length)
         {
            count = this.margin;
            ar = this._tfs[i];
            j = 0;
            while(j < ar.length)
            {
               tf = ar[j];
               if(j != 0)
               {
                  count += maxWidthMap[j - 1];
                  count += hgap;
               }
               tf.x = count;
               tf.y = sy + i * 18;
               th = tf.y + tf.textHeight;
               if(th > maxHeight)
               {
                  maxHeight = th;
               }
               tw = tf.x + tf.textWidth;
               if(tw > maxWidth)
               {
                  maxWidth = tw;
               }
               j += 1;
            }
            i += 1;
         }
         i = 0;
         while(i < this._tfs.length)
         {
            ar = this._tfs[i];
            if(ar.length > 1)
            {
               rightBarTf = ComponentUtil.getTextField("】",this);
               rightBarTf.color = 5635925;
               rightBarTf.y = ar[0].y;
               rightBarTf.x = maxWidth + vgap;
               maxWidth2 = rightBarTf.x + rightBarTf.textWidth + this.margin;
               ar.push(rightBarTf);
            }
            i += 1;
         }
         this._tfTip.visible = this._tfs.length > 0;
         ww = Math.max(maxWidth2,maxWidth + this.margin,110,this._tfTip.x + this._tfTip.textWidth + this.margin);
         hh = Math.max(maxHeight,this._info.y + this._info.textHeight + this.margin);
         if(this._tfTip.visible)
         {
            this._tfTip.y = hh + this.margin;
            ww = Math.max(ww,this._tfTip.x + this._tfTip.textWidth + this.margin);
            hh = Math.max(hh,this._tfTip.y + this._tfTip.textHeight + this.margin);
         }
         this._border1.width = ww;
         this._border1.height = hh;
      }
      
      private function tryInit() : void
      {
         if(this._isinit)
         {
            return;
         }
         this._isinit = true;
         this._border1 = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":117,
            "height":95
         },Global.Img_Cdm);
         addChild(this._border1);
         this._line = ComponentUtil.getDisplayObject("Lines",this,{
            "x":this.margin,
            "y":30,
            "size":14,
            "width":100
         });
         this._tfName = ComponentUtil.getTextField("星点累加总属性：",this,{
            "x":this.margin,
            "y":this.margin,
            "color":16777011
         });
         this._info = ComponentUtil.getTextField("",this,{
            "x":this.margin,
            "y":35,
            "leading":this.__leading,
            "color":16777215
         });
         this._tfName2 = ComponentUtil.getTextField("装备附加属性:",this,{
            "x":this.margin,
            "visible":false,
            "color":16777011
         });
         this._tfTip = ComponentUtil.getTextField("装备所加属性为装备基础属性",this,{
            "x":this.margin,
            "color":16746632
         });
      }
   }
}

