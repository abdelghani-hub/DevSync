package org.youcode.devsync.service;

import org.youcode.devsync.model.Token;
import org.youcode.devsync.repository.TokenRepository;

import java.util.List;
import java.util.Optional;

public class TokenService {
    private final TokenRepository tokenRepository;

    public TokenService() {
        tokenRepository = new TokenRepository();
    }

    public List<Token> getAllTokens() {
        return tokenRepository.findAll();
    }

    public Token createToken(Token token) {
        Optional<Token> tokenOp = tokenRepository.create(token);
        tokenOp.ifPresent(t -> t.setId(t.getId()));
        return token;
    }

    public Optional<Token> updateToken(Token token) {
        return tokenRepository.update(token);
    }

}
