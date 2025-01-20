--- STEAMODDED HEADER
--- MOD_NAME: PauperDeck
--- MOD_ID: pauperdeck
--- MOD_AUTHOR: [Aiksi]
--- MOD_DESCRIPTION: It's a deck!
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1216c]
--- VERSION: 1.05

----------------------------------------------
------------MOD CODE -------------------------

-- Texture Atlas
SMODS.Atlas {
	key = "pauper_atlas",
	path = "pauper_atlas.png",
	px = 71,
	py = 95,
}

--  Deck
SMODS.Back {
    key = "Pauper deck",
--  Disables interest and hands reward money
    config = {no_interest = true, extra_hand_bonus = 0},
    pos = { x = 0, y = 0 },
	atlas = "pauper_atlas",
    loc_txt = {
        name = "Pauper deck",
        text = {
            "Only {C:attention}Jokers{} can earn you {C:money}${}",
			"Start with",
			"an {C:purple}Eternal{} {C:dark_edition}Negative{} {C:attention,T:j_gift}Gift Card{p:1}",
			"Shop has no {C:attention}Jokers{}",
			"Open a {C:attention,T:p_buffoon_jumbo_1}Jumbo Pack{}",
			"after defeating a {C:attention}Blind{}",
        }
    },

	apply = function()
--  Disables jokers from appearing in the shop
		G.GAME.joker_rate = 0
--  Disables blind reward money
		G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
		G.GAME.modifiers.no_blind_reward.Small = true
		G.GAME.modifiers.no_blind_reward.Big = true
		G.GAME.modifiers.no_blind_reward.Boss = true
--  Bans
		G.GAME.banned_keys['m_gold'] = true
		G.GAME.banned_keys['m_lucky'] = true
		G.GAME.banned_keys['Gold'] = true
		G.GAME.banned_keys['c_judgement'] = true
		G.GAME.banned_keys['c_hermit'] = true
		G.GAME.banned_keys['c_temperance'] = true
		G.GAME.banned_keys['c_devil'] = true
		G.GAME.banned_keys['c_magician'] = true
--		G.GAME.banned_keys['c_wraith'] = true
--		G.GAME.banned_keys['c_soul'] = true
		G.GAME.banned_keys['c_immolate'] = true
		G.GAME.banned_keys['c_talisman'] = true
		G.GAME.banned_keys['p_buffoon_normal_1'] = true
		G.GAME.banned_keys['p_buffoon_normal_2'] = true
		G.GAME.banned_keys['p_buffoon_jumbo_1'] = true
		G.GAME.banned_keys['p_buffoon_mega_1'] = true
		G.GAME.banned_keys['tag_rare'] = true
		G.GAME.banned_keys['tag_uncommon'] = true
		G.GAME.banned_keys['tag_holo'] = true
		G.GAME.banned_keys['tag_polychrome'] = true
		G.GAME.banned_keys['tag_negative'] = true
		G.GAME.banned_keys['tag_foil'] = true
		G.GAME.banned_keys['tag_buffoon'] = true
		G.GAME.banned_keys['tag_top_up'] = true
		G.GAME.banned_keys['tag_investment'] = true
		G.GAME.banned_keys['tag_handy'] = true
		G.GAME.banned_keys['tag_garbage'] = true
		G.GAME.banned_keys['tag_skip'] = true
		G.GAME.banned_keys['tag_economy'] = true
		G.GAME.banned_keys['v_seed_money'] = true
		G.GAME.banned_keys['v_money_tree'] = true
		G.GAME.banned_keys['j_swashbuckler'] = true
		G.GAME.banned_keys['j_midas_mask'] = true
		G.GAME.banned_keys['j_to_the_moon'] = true
		G.GAME.banned_keys['j_lucky_cat'] = true
		G.GAME.banned_keys['j_ticket'] = true

--  Spawns an Eternal Negative Gift Card at the beginning of the game
		G.E_MANAGER:add_event(Event({
			func = function()
				add_joker('j_gift', 'negative', true, true)
			return true
			end
		}))
	end,

--  Spawns a Jumbo Pack after a Blind is defeated
	trigger_effect = function(self, args)
		if args.context == 'eval' and G.GAME.last_blind then

			local key = "p_buffoon_jumbo_1"
			local card = Card(
				G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
				G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
				G.CARD_W * 1.27,
				G.CARD_H * 1.27,
				G.P_CARDS.empty,
				G.P_CENTERS[key],
				{ bypass_discovery_center = true, bypass_discovery_ui = true }
			)
			card.cost = 0
			G.FUNCS.use_card({ config = { ref_table = card } } )
			card:start_materialize()

--  Decreases the price of each consumable at the end of the round to counterract Gift Card's effect
			for k, v in ipairs(G.consumeables.cards) do
				if v.set_cost then 
					v.ability.extra_value = (v.ability.extra_value or 0) - 1
					v:set_cost()
				end
			end
			return true
		end
    end
}

--  Old code that I wanted to stash around somewhere, idk might be handy for something else later

--			G.E_MANAGER:add_event(Event({
--				func = function()
--					add_tag(Tag('tag_buffoon'))
--					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
--					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
--					return true
--				end
--			}))
--SMODS.Center._disable = function(self, reason)
--	if not self.cry_disabled then
--		self.cry_disabled = reason or { type = "manual" } --used to display more information that can be used later
--		SMODS.remove_pool(G.P_CENTER_POOLS["Booster"], "m_gold")
--		G.P_CENTERS["m_gold"] = nil
--	end
--end
--local Backapply_to_runRef = Back.apply_to_run
--function Back.apply_to_run(arg)
--	Backapply_to_runRef(arg)
--	if arg.effect.config.pauper_deck then
--		G.E_MANAGER:add_event(Event({
--			func = function()
--				add_joker('j_gift', 'negative', true, true)
--			return true
--			end
--		}))
--	end
--end

----------------------------------------------
------------MOD CODE END----------------------