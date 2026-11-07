package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_WeiLie;
   import com.yiTian.view.modules.weilie.View_WeiLie;
   import flash.utils.Dictionary;
   
   public class Model_WeiLie
   {
      
      private static var _inst:Model_WeiLie;
      
      public static var tempA:Number;
      
      public static var tempB:Number;
      
      public static var tempC:Number;
      
      public static var tempD:Number;
      
      public static var tempE:Number;
      
      public static const QZYG:String = "Title_QXWL";
      
      public static const QZGS:String = "Title_QZGS";
      
      private static var dic:Dictionary = new Dictionary();
      
      private static var modelDic:Dictionary = new Dictionary();
      
      public static var anglePos:Array = [[],[-157,-20,30,200,100,500],[-102,145,-110,80,230,300],[-140,-20,-50,180,150,200],[-157,-70,20,200,100,500],[-147,-25,-20,210,130,500],[-127,-10,-135,155,195,300],[-167,-80,50,200,60,500],[-147,-30,-20,170,110,500],[-108,80,-160,110,250,200],[-137,-20,-50,180,150,500],[-157,-70,20,200,100,500],[-117,40,-150,130,210,200]];
      
      public var nowVo:Vo_WeiLie = new Vo_WeiLie();
      
      public var data_log:Vector.<Vo_WeiLie> = new Vector.<Vo_WeiLie>();
      
      public var currentPer:Number;
      
      public var time:int;
      
      public var currentXF:int;
      
      public var maxXF:int;
      
      public var index:int = 2;
      
      public var datalog:String = "";
      
      private var _isRunning:Boolean;
      
      public var _lib:DictionaryTabel;
      
      private var _view:View_WeiLie;
      
      public function Model_WeiLie(title:String = "Title_QXWL")
      {
         super();
         this.lib(title);
      }
      
      public static function ins(key:String) : Model_WeiLie
      {
         return modelDic[key] || (modelDic[key] = new Model_WeiLie(key));
      }
      
      public function get isRunning() : Boolean
      {
         return this._isRunning;
      }
      
      public function set isRunning(value:Boolean) : void
      {
         this._isRunning = value;
         this._view.getBtn.enabled = !value;
      }
      
      public function lib(_title:String) : void
      {
         if(_title == QZYG)
         {
            this._lib = Data_lib.qunxiaweilie;
         }
         else
         {
            this._lib = Data_lib.qizhenyiguo;
         }
      }
      
      public function update() : void
      {
         var i:int = 1;
         var maxTime:int = 1;
         while(this.currentXF >= this._lib[i][6])
         {
            maxTime++;
            i++;
            if(i >= this._lib.getLength())
            {
               break;
            }
         }
         this.maxXF = this._lib[maxTime][6];
         this.currentPer = this.currentXF / this.maxXF;
         if(this.currentPer >= 1)
         {
            this.currentPer = 1;
         }
      }
      
      public function get view() : View_WeiLie
      {
         if(!this._view)
         {
            this._view = new View_WeiLie();
            this._view.loadlib();
         }
         return this._view;
      }
   }
}

