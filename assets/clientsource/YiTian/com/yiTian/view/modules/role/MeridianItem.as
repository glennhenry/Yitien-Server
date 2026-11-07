package com.yiTian.view.modules.role
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class MeridianItem extends Sprite
   {
      
      public static const NAME:int = 0;
      
      public static const TYPE:int = 1;
      
      public static const LEVEL:int = 2;
      
      public static const EFFCOLOR:int = 3;
      
      public static const NEXT:int = 6;
      
      public static const NEEDPROPS:int = 8;
      
      public static const NEEDPROPSNUMS:int = 9;
      
      public static const DESCRIPTION:int = 11;
      
      private var txtName:MyTextField;
      
      private var txtLevel:MyTextField;
      
      private var txtDescription:MyTextField;
      
      private var txtNums:MyTextField;
      
      private var btnUpgrade:Button;
      
      private var _isCan:Boolean;
      
      private var _id:int;
      
      private var needN:int;
      
      public function MeridianItem()
      {
         super();
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back_Invite",[5,5,6,6],this,{
            "x":0,
            "y":0,
            "width":197,
            "height":60
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":8,
            "y":8,
            "width":44,
            "height":44
         },Global.Img_Cdm);
         this.txtName = ComponentUtil.getTextField("",this,{
            "x":14,
            "y":11,
            "color":14662240,
            "size":14,
            "leading":0
         });
         this.txtName.size = 14;
         this.txtLevel = ComponentUtil.getTextField("",this,{
            "x":15,
            "y":30,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.txtLevel.realWidth = 32.2;
         this.txtLevel.align = TextFormatAlign.CENTER;
         this.txtDescription = ComponentUtil.getTextField("",this,{
            "x":55,
            "y":10,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.txtNums = ComponentUtil.getTextField("",this,{
            "x":55,
            "y":32,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.btnUpgrade = ComponentUtil.getButton(LangConfig.getWord("10032",1),"Button_Two",this,{
            "x":145,
            "y":30,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnUpgrade.textColor = 16776960;
         this.btnUpgrade.textOverColor = 16776960;
         this.btnUpgrade.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function getElements(elementsName:String) : Object
      {
         return this[elementsName];
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var myWay:int = int(Enum_job.getChildWay(GameUnitManager.hero.job));
         if(Data_lib.meridian[this._id][NEXT] == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10033",1));
            return;
         }
         var needNums:int = int(Data_lib.meridian[this._id][NEEDPROPSNUMS]);
         var bagNums:int = this.getNums(Data_lib.meridian[this._id][NEEDPROPS]);
         if(bagNums < needNums)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10034",1));
            return;
         }
         if(myWay == 0 && Data_lib.meridian[this._id][LEVEL] >= 10)
         {
            UIManager.centerBroadcast.addMsg("职业进阶后才能升级高阶经脉",1);
            return;
         }
         RoleCGMessage.CG_MERIDIAN_UP(Data_lib.meridian[this._id][TYPE]);
      }
      
      public function isCan() : Boolean
      {
         return this._isCan;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(value:int) : void
      {
         this._id = value;
         this.txtName.text = Data_lib.meridian[this._id][NAME];
         this.txtLevel.text = Data_lib.meridian[this._id][LEVEL] + LangConfig.getWord("10031",1);
         this.txtDescription.text = Data_lib.meridian[this._id][DESCRIPTION];
         var needNums:int = int(Data_lib.meridian[this._id][NEEDPROPSNUMS]);
         this.needN = needNums;
         var bagNums:int = this.getNums(Data_lib.meridian[this._id][NEEDPROPS]);
         if(bagNums < needNums || Data_lib.meridian[this._id][NEXT] == 0)
         {
            this._isCan = false;
         }
         else
         {
            this._isCan = true;
         }
         if(Data_lib.meridian[this._id][LEVEL] >= View_role_meridian.getMaxLv())
         {
            this.txtNums.htmlText = LangConfig.getWord("782",0);
            this.btnUpgrade.enabled = false;
         }
         else
         {
            this.txtNums.htmlText = Data_lib.meridian[this._id][NEEDPROPS] != "0" ? Enum_BroadCastTool.instance.getItemText(Data_lib.meridian[this._id][NEEDPROPS]) + (bagNums > needNums ? needNums + "/" + needNums : bagNums + "/" + needNums) : LangConfig.getWord("782",0);
            this.btnUpgrade.enabled = true;
         }
      }
      
      public function set needNums(value:int) : void
      {
         this.needN = value;
      }
      
      public function get needNums() : int
      {
         return this.needN;
      }
      
      private function getNums(id:int) : int
      {
         var nums:int = 0;
         var i:uint = 0;
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[id]);
         if(Boolean(vec))
         {
            i = 0;
            while(i < vec.length)
            {
               nums += vec[i].count;
               i++;
            }
         }
         return nums;
      }
   }
}

