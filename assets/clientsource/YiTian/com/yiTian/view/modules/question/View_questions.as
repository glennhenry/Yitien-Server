package com.yiTian.view.modules.question
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CheckCGMessage;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_questions extends Panel
   {
      
      public static var firstInit:Boolean = true;
      
      private static var dicLen:int = 7;
      
      private static var moveDistance:int = 200;
      
      private var containers:Sprite;
      
      private var maskContains:Sprite;
      
      private var mouseControl:Sprite;
      
      private var btn1:Button;
      
      private var btn2:Button;
      
      private var dataArr:Array = ["89789","sdgsdg","bbbbb","ggggg","rrrrr"];
      
      private var totalArr:Array = [];
      
      private var typeArr:Array = [];
      
      private var titleArr:Array = [];
      
      private var sureBtn:Button;
      
      private var _index:int = 0;
      
      private var optionStr:String = "";
      
      private var others:String = "";
      
      private var tfLink:MyTextField;
      
      private var ifInp:int;
      
      private var linkBtn:Button;
      
      public function View_questions()
      {
         super();
         this.initData();
      }
      
      private function initData() : void
      {
         var i:int = 1;
         while(i <= dicLen)
         {
            this.titleArr.push(i + "、" + Data_lib.questionsCheck[i][2]);
            this.totalArr.push((Data_lib.questionsCheck[i][3] as String).split("-"));
            this.typeArr.push([Data_lib.questionsCheck[i][0],Data_lib.questionsCheck[i][1]]);
            i++;
         }
         Utils.loadTitle("lang/ch/DiaoCha.swf","DiaoCha_Back",new Bitmap(),{
            "x":0,
            "y":0
         },this,this.comp);
      }
      
      private function comp() : void
      {
         var tf:MyTextField;
         var st:String;
         move = new Rectangle(0,0,512,30);
         ComponentUtil.getButton("","Button_XSClose",this,{
            "x":440,
            "y":25,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         tf = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":70,
            "color":0,
            "size":14,
            "leading":2,
            "filters":[],
            "multiline":true,
            "wordWrap":true,
            "bold":true,
            "realWidth":425
         });
         st = HtmlUtil.font("神秘奖励",ColorConstant.getColorStr(ColorConstant.ORANGE),14);
         tf.htmlText = "亲爱的用户，您好！" + "\n" + "       为了给您提供更好的产品和服务，我们正在进行一场关于倚天的调查，" + "" + "以下问卷当中所有的题目均无对错之分，您只需按照题目的顺序，根据您" + "" + "的真实情况填写即可，谢谢!\n（成功完成提交问卷调查可获得  " + st + " 哦）";
         this.containers = new Sprite();
         this.maskContains = new Sprite();
         this.maskContains.graphics.beginFill(0,1);
         this.maskContains.graphics.drawRect(35,190,441,253);
         this.maskContains.graphics.endFill();
         addChild(this.maskContains);
         this.containers.x = 35;
         this.containers.y = 190;
         addChild(this.containers);
         this.containers.mask = this.maskContains;
         this.btn1 = ComponentUtil.getButton("左翻页","Button_Four",this,{
            "x":118,
            "y":36
         },Global.Img_Cdm);
         this.btn2 = ComponentUtil.getButton("右翻页","Button_Four",this,{
            "x":340,
            "y":36
         },Global.Img_Cdm);
         this.btn1.visible = this.btn2.visible = false;
         this.sureBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":220,
            "y":415,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn1.callBack = this.btn2.callBack = this.changHd;
         if(firstInit)
         {
            this.questionId = "右翻页";
            firstInit = false;
         }
         this.sureBtn.callBack = this.sureHd;
      }
      
      private function link(e:Object) : void
      {
         UIManager.letterManagerViewPanel.visible = !UIManager.letterManagerViewPanel.visible;
         if(UIManager.letterManagerViewPanel.visible)
         {
            LetterCGMessage.CG_MAIL(1,1);
         }
         this.visible = false;
      }
      
      public function set questionId(typeStr:String) : void
      {
         var _n:int;
         var num:int = 0;
         var que:Child_question = null;
         var item:Child_question = null;
         if(!visible)
         {
            this.visible = true;
         }
         num = typeStr == "左翻页" ? 400 : -400;
         this._index = Model_question.questionId;
         this.btnStus = Model_question.sureBtnS;
         if(!this.sureBtn.visible)
         {
            this.sureBtn.visible = true;
         }
         this.sureBtn.enabled = false;
         _n = this.containers.numChildren;
         if(Boolean(_n))
         {
            item = this.containers.getChildAt(_n - 1) as Child_question;
            Tween.to(item,200,{"x":[item.x,item.x + num]},function():void
            {
               item.dispose();
            });
         }
         que = Child_question.instance;
         if(this._index == dicLen)
         {
            this.btn2.enabled = false;
         }
         else
         {
            this.btn2.enabled = true;
         }
         if(this._index == 1)
         {
            this.btn1.enabled = false;
         }
         else
         {
            this.btn1.enabled = true;
         }
         que.setQuestion(this.titleArr[this._index - 1],this.totalArr[this._index - 1],this.typeArr[this._index - 1][0],this.typeArr[this._index - 1][1]);
         que.x = 480;
         que.y = 40;
         this.containers.addChild(que);
         Tween.to(que,200,{"x":[90 - num,90]});
      }
      
      private function changHd(e:MouseEvent) : void
      {
         this.questionId = e.target.label;
      }
      
      public function set btnStus(value:int) : void
      {
         if(value == 1)
         {
            this.sureBtn.label = "提交";
         }
         else if(value == 0)
         {
            this.sureBtn.label = "确定";
         }
      }
      
      private function sureHd(e:MouseEvent) : void
      {
         var bn:Button = e.target as Button;
         if(this.ifInp != -1)
         {
            if(this.others == "")
            {
               UIManager.centerBroadcast.addMsg("请在其他选项输入文字");
               return;
            }
         }
         if(bn.label == "提交")
         {
            CheckCGMessage.CG_HANDUP_QUESTION(1,Model_question.questionId,this.optionStr,this.others);
         }
         else if(bn.label == "确定")
         {
            if(Model_question.questionId == 2 && this.optionStr == "D")
            {
               CheckCGMessage.CG_HANDUP_QUESTION(1,Model_question.questionId,this.optionStr,this.others);
            }
            CheckCGMessage.CG_HANDUP_QUESTION(2,Model_question.questionId,this.optionStr,this.others);
         }
      }
      
      public function updataBtn(isSel:Boolean, _s1:String, _s2:String) : void
      {
         var ss:String = null;
         var sss:String = null;
         this.sureBtn.enabled = isSel;
         var arr:Array = _s1.split("_");
         this.optionStr = "";
         this.others = "";
         this.ifInp = _s2.search("CGX_0503");
         _s2 = _s2.replace("CGX_0503","");
         if(Boolean(arr.length))
         {
            if(arr[arr.length - 1] == "")
            {
               arr.pop();
            }
         }
         var i:int = 0;
         while(i < arr.length)
         {
            ss = arr[i];
            sss = i == arr.length - 1 ? "" : "_";
            this.optionStr += ss + sss;
            i++;
         }
         this.others = _s2;
      }
      
      public function endHd() : void
      {
         var item:Child_question = null;
         var _n:int = this.containers.numChildren;
         if(Boolean(_n))
         {
            item = this.containers.getChildAt(_n - 1) as Child_question;
            item.dispose();
         }
         Utils.loadTitle("lang/ch/DiaoCha.swf","DiaoCha_End",new Bitmap(),{
            "x":90,
            "y":40
         },this.containers);
         if(!this.linkBtn)
         {
            this.linkBtn = ComponentUtil.getButton("领取奖励","Button_Four",this.containers,{
               "x":190,
               "y":180
            },Global.Img_Cdm);
            this.linkBtn.addEventListener(MouseEvent.CLICK,this.link);
         }
         this.sureBtn.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            Tween.to(this,300,{
               "alpha":[0,1],
               "y":[(Global.stage.stageHeight - 460) / 2 - 50,(Global.stage.stageHeight - 460) / 2]
            });
         }
         else
         {
            Tween.to(this,300,{
               "alpha":[1,0],
               "y":[(Global.stage.stageHeight - 460) / 2,(Global.stage.stageHeight - 460) / 2 - 50]
            },this._cmp);
         }
      }
      
      private function _cmp() : void
      {
         this._index = 0;
         super.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 512) / 2;
         y = (Global.stage.stageHeight - 460) / 2;
      }
   }
}

