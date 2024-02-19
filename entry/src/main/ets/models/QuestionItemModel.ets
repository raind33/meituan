export class QueryQuestionListParams {
  type!: number
  page!: number
  questionBankType!: number
  sort?: number
  keyword?: string
}

@Observed
export class QuestionItemModel {
  public id!: string
  public stem!: string
  public difficulty!: number
  public likeCount!: number
  public views!: number
  public readFlag?: 0 | 1
}