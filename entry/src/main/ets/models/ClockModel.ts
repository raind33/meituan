export class ClockModel {
  flag?: boolean
  clockinNumbers?: number
  totalClockinNumber?: number
  clockins?: ClockInModel[]
}

export class ClockInModel {
  id: string
  createdAt: string
}