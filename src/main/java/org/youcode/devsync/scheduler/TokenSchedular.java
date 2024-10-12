package org.youcode.devsync.scheduler;

import org.youcode.devsync.model.Tag;
import org.youcode.devsync.model.Token;
import org.youcode.devsync.service.TagService;
import org.youcode.devsync.service.TokenService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TokenSchedular {
    private final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
    private final TokenService tokenService = new TokenService();

    public void startTokenScheduler() {
        scheduler.scheduleAtFixedRate(this::resetTokens, 0, 1, TimeUnit.DAYS);
    }

    private void resetTokens() {
        List<Token> tokens = tokenService.getAllTokens();
        tokens.forEach(
                token -> {
                    // Reset the modification tokens every day
                    if (token.getLastResetDate().isBefore(LocalDateTime.now().minusDays(1))) {
                        token.setModificationTokens(2);
                    }
                    // Reset the deletion tokens every month
                    if(token.getLastResetDate().isBefore(LocalDateTime.now().minusMonths(1))) {
                        token.setDeletionTokens(1);
                    }
                    token.setLastResetDate(LocalDateTime.now());
                    tokenService.updateToken(token);
                }
        );
    }

    public void stopTokenScheduler() {
        scheduler.shutdown();
    }
}
