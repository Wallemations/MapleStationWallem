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

export const DrinksMenu = (props) => {
  const { data } = useBackend<Data>();
  const { all_drinks } = data;

  return (
    <Window width={335} height={335}>
      <Window.Content scrollable>
        <Section title="Drinks Menu">
          <Table>
            {all_drinks.map((all_drinks) => (
              <Table.Row key={all_drinks.name}>
                {all_drinks.name}
                {all_drinks.desc}
                {all_drinks.alcohol} alcohol level
                <Collapsible title="Recipe">
                  {all_drinks.recipes?.map((recipe) =>
                    recipe.reagents.map((reagent) => (
                      <Box key={reagent.name}>
                        {reagent.name} {reagent.amount}
                      </Box>
                    )),
                  )}
                </Collapsible>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
