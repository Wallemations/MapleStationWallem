import {
  Box,
  Button,
  Collapsible,
  Icon,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  all_drinks: Drink[];
};

type Drink = {
  name: string;
  desc: string;
  recipes?: Recipe[];
  alcohol: number;
  icon?: string;
  icon_state?: string;
};

type Recipe = {
  reagents: Reagent[];
};

type Reagent = {
  name: string;
  amount: number;
  color: string;
};

export const DrinkMenu = (props) => {
  const { data } = useBackend<Data>();
  const { all_drinks } = data;
  console.log(JSON.stringify(all_drinks));

  return (
    <Window width={335} height={335}>
      <Window.Content scrollable>
        <Section title="Drinks Menu">
          {!!all_drinks.length && (
            <Table>
              {all_drinks.map((drink) => (
                <Table.Row key={drink.name}>
                  {drink.name}
                  {drink.desc}
                  {drink.alcohol} alcohol level
                  {!!drink.recipes?.length && (
                    <Collapsible title="Recipe">
                      {drink.recipes?.map((recipe) =>
                        recipe.reagents.map((reagent) => (
                          <Box key={reagent.name}>
                            {reagent.name} {reagent.amount}
                          </Box>
                        )),
                      )}
                    </Collapsible>
                  )}
                </Table.Row>
              ))}
            </Table>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
