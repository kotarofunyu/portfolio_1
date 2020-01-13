class TrainingRecordController < ApplicationController

  # 作成と表示を同画面で行う
  def index
    # 新規作成
    @record = TrainingRecord.new
    recordevent= @record.event.build
    recordevent.set_datum.build
    
    # 全ての投稿を取得して、作成日昇順でソートする
    @records = TrainingRecord.all.includes(:event).order(created_at: "DESC")

    @menuname = MenuName.new
  end

  # 記録詳細ページ”
  def show
    #パタメーターから投稿を取得して変数に代入
    @record = TrainingRecord.find_by(id: params[:id])
  end

  # フォームからの記録をDBに登録する処理
  def create
    @record = TrainingRecord.new(training_record_params)
    if @record.save
      redirect_to("/records")
    end
  end

  # 種目名の登録
  def register
    @menuname = MenuName.new(menu_name_params)
    if @menuname.save
      redirect_to("/records")
    else
      render("index")
    end
  end

  def edit
  end

  # 記録削除
  def destroy
    # 削除対象の記録を取得
    @record = TrainingRecord.find_by(id: params[:id])
    # 削除対象の記録を削除する
    @record.destroy
    # 記録一覧へリダイレクトする
    redirect_to("/records")
  end

  # 種目別の一覧ページ
  def event
    @events = Event.where(name: params[:name]).order(created_at: "DESC")
  end

  # ストロングパラメーター
  private
    def training_record_params
      # 小テーブルの種目テーブルも同時にパラメータ取得
        params.require(:training_record).permit(:comment, :picture, event_attributes:[:id, :part, :name, set_datum_attributes:[:weight, :rep, :set]]).merge(user_id: current_user.id)
    end

    def menu_name_params
      params.require(:menu_name).permit(:name)
    end
end
