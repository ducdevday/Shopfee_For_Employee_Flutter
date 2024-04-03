part of history;

class HistorySkeletonItem extends StatelessWidget {
  const HistorySkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppDimen.spacing, bottom: 5),
      color: Colors.black38,
      child: const Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppDimen.screenPadding),
                child: Row(
                  children: [
                    MySkeletonCircle(
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    MySkeletonRectangle(width: 60, height: 20),
                  ],
                ),
              ),
              Divider(
                height: 10,
                indent: AppDimen.screenPadding,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                child: Row(children: [
                  MySkeletonRectangle(width: 70, height: 70),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: MySkeletonRectangle(
                              width: 40,
                              height: 20,
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            MySkeletonRectangle(
                              width: 60,
                              height: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MySkeletonRectangle(
                          width: 60,
                          height: 10,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MySkeletonRectangle(
                          width: 60,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Divider(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: MySkeletonRectangle(
                  width: 100,
                  height: 40,
                )),
          )
        ],
      ),
    );
  }
}
