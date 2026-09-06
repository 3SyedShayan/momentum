part of '../profile.dart';

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    final initial = state.displayName.isNotEmpty
        ? state.displayName[0].toUpperCase()
        : 'S';

    return Container(
      padding: EdgeInsets.all(SpaceToken.t20),
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
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ProfileData.avatarStartColor,
                  ProfileData.avatarEndColor,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Space.x.t16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.displayName,
                  style: AppText.h3b.cl(AppTheme.c.text),
                ),
                Space.y.t04,
                Text(
                  state.email,
                  style: AppText.b2.cl(AppTheme.c.subText),
                ),
                Space.y.t08,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      LucideIcons.flame,
                      size: 13,
                      color: ProfileData.streakColor,
                    ),
                    Space.x.t04,
                    Text(
                      '${state.streakCount}-day streak',
                      style: AppText.b2b.cl(ProfileData.streakColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
