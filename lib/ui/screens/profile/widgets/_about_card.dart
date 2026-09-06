part of '../profile.dart';

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT',
          style: AppText.b2b.cl(AppTheme.c.subText).copyWith(
            letterSpacing: 1.0,
            fontSize: 11,
          ),
        ),
        Space.y.t08,
        Container(
          decoration: BoxDecoration(
            color: AppTheme.c.specBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.c.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ...ProfileData.aboutLinks.asMap().entries.map((entry) {
                final link = entry.value;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$link coming soon!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SpaceToken.t20,
                          vertical: SpaceToken.t16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              link,
                              style: AppText.b1.cl(AppTheme.c.text),
                            ),
                            Icon(
                              LucideIcons.chevron_right,
                              size: 16,
                              color: AppTheme.c.subText.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.c.border.withValues(alpha: 0.5),
                    ),
                  ],
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t20,
                  vertical: SpaceToken.t16,
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 14,
                      color: AppTheme.c.subText.withValues(alpha: 0.6),
                    ),
                    Space.x.t08,
                    Expanded(
                      child: Text(
                        'Momentum v1.0.0 — Built with intention.',
                        style: AppText.l1.cl(
                          AppTheme.c.subText.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
